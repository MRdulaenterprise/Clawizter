#!/usr/bin/env node
/**
 * Clawitzer Agent – unified OS daemon (Option A: OpenClaw-based).
 * If openclaw is installed, run its gateway via CLI; otherwise run a minimal placeholder.
 */
const http = require('http');
const path = require('path');
const { spawn } = require('child_process');

const PORT = process.env.CLAWITZER_AGENT_PORT || 19898;
const CONFIG_DIR = process.env.CLAWITZER_CONFIG_DIR || path.join(process.env.HOME || '/root', '.config/clawitzer');

function startPlaceholder() {
  const server = http.createServer((req, res) => {
    res.setHeader('Content-Type', 'application/json');
    if (req.url === '/health' || req.url === '/') {
      res.writeHead(200);
      res.end(JSON.stringify({
        name: 'Clawitzer Agent',
        status: 'running',
        mode: 'placeholder',
        message: 'OpenClaw not installed. Install openclaw for full features. Config: ' + CONFIG_DIR,
      }));
      return;
    }
    res.writeHead(404);
    res.end(JSON.stringify({ error: 'Not found' }));
  });
  server.listen(PORT, '127.0.0.1', () => {
    console.log(`Clawitzer Agent (placeholder) listening on http://127.0.0.1:${PORT}`);
  });
}

function tryRunOpenClaw() {
  const openclawPath = path.join(__dirname, '..', 'node_modules', '.bin', 'openclaw');
  const fs = require('fs');
  if (!fs.existsSync(openclawPath)) return false;
  const child = spawn(process.execPath, [openclawPath, 'gateway', 'run', '--port', String(PORT)], {
    cwd: path.join(__dirname, '..'),
    stdio: 'inherit',
    env: { ...process.env, CLAWITZER_CONFIG_DIR: CONFIG_DIR },
  });
  child.on('error', (err) => {
    console.error('OpenClaw failed:', err.message);
    startPlaceholder();
  });
  child.on('exit', (code) => {
    if (code !== 0 && code !== null) {
      console.error('OpenClaw exited with code', code, '- falling back to placeholder');
      startPlaceholder();
    }
  });
  return true;
}

if (!tryRunOpenClaw()) {
  startPlaceholder();
}
