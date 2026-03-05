#!/usr/bin/env node
/**
 * Clawitzer Agent – unified OS daemon (Option A: OpenClaw-based).
 * If openclaw is installed, delegate to it; otherwise run a minimal placeholder
 * that serves setup info and health.
 */
const http = require('http');
const path = require('path');

const PORT = process.env.CLAWITZER_AGENT_PORT || 19898;
const CONFIG_DIR = process.env.CLAWITZER_CONFIG_DIR || path.join(process.env.HOME || '/root', '.config/clawitzer');

function tryOpenClaw() {
  try {
    require.resolve('openclaw');
    return require('openclaw');
  } catch {
    return null;
  }
}

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

const openclaw = tryOpenClaw();
if (openclaw && typeof openclaw.run === 'function') {
  openclaw.run().catch((err) => {
    console.error('OpenClaw failed, falling back to placeholder:', err.message);
    startPlaceholder();
  });
} else {
  startPlaceholder();
}
