#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

# Hugo's Tailwind v4 transform requires the `tailwindcss` binary to be a Node.js
# script, but pnpm installs node_modules/.bin/tailwindcss as a /bin/sh shim, which
# Hugo rejects ("binary tailwindcss is not a Node.js script"). Repair it here so a
# plain `./view.sh` works even right after `pnpm install`. Idempotent.
tw="node_modules/.bin/tailwindcss"
if [ -f "$tw" ] && head -1 "$tw" | grep -q '/bin/sh'; then
  echo "Patching node_modules/.bin/tailwindcss for Hugo (pnpm shim -> Node.js script)…"
  cat > "$tw" <<'EOF'
#!/usr/bin/env node
const path = require("path");
import(path.join(__dirname, "..", "@tailwindcss", "cli", "dist", "index.mjs"));
EOF
  chmod +x "$tw"
fi

hugo server --disableFastRender --printI18nWarnings "$@"
