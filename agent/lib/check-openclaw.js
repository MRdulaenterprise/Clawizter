#!/usr/bin/env node
// Optional: print hint if openclaw is not installed (postinstall script).
try {
  require.resolve('openclaw');
} catch {
  console.log('Clawitzer Agent: optional dependency "openclaw" not installed. Run: npm install openclaw');
}
