#!/usr/bin/env node

import { fileURLToPath } from "url";
import path from "path";
import { execSync } from "child_process";

// Get the current directory in an ES module
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const scriptPath = path.join(__dirname, "mern-setup.sh");

const quotedScriptPath = `"${scriptPath}"`;

try {
  execSync(`bash ${quotedScriptPath}`, { stdio: "inherit" });
} catch (error) {
  console.error("Error executing the shell script:", error.message);
  process.exit(1);
}
