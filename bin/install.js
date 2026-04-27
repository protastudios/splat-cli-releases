#!/usr/bin/env node
"use strict";

const fs = require("fs");
const os = require("os");
const path = require("path");

const packageRoot = path.resolve(__dirname, "..");

function printHelp() {
  console.log(`Usage:
  splat-agent-skills install [options]
  splat-agent-skills --help

Options:
  --codex                 Install only the Codex skill
  --claude                Install only the Claude Code command/snippet
  --codex-home <path>     Override Codex home directory
  --claude-home <path>    Override Claude home directory
  --dry-run               Print planned file operations without writing

Environment:
  CODEX_HOME              Codex home directory, default ~/.codex
  CLAUDE_HOME             Claude home directory, default ~/.claude
`);
}

function parseArgs(argv) {
  const options = {
    command: "install",
    codex: false,
    claude: false,
    codexHome: process.env.CODEX_HOME || path.join(os.homedir(), ".codex"),
    claudeHome: process.env.CLAUDE_HOME || path.join(os.homedir(), ".claude"),
    dryRun: false,
  };

  const args = [...argv];
  if (args[0] && !args[0].startsWith("-")) {
    options.command = args.shift();
  }

  for (let index = 0; index < args.length; index += 1) {
    const arg = args[index];

    if (arg === "--help" || arg === "-h") {
      options.command = "help";
    } else if (arg === "--codex") {
      options.codex = true;
    } else if (arg === "--claude") {
      options.claude = true;
    } else if (arg === "--dry-run") {
      options.dryRun = true;
    } else if (arg === "--codex-home") {
      options.codexHome = readValue(args, index, arg);
      index += 1;
    } else if (arg === "--claude-home") {
      options.claudeHome = readValue(args, index, arg);
      index += 1;
    } else {
      throw new Error(`Unknown option: ${arg}`);
    }
  }

  if (!options.codex && !options.claude) {
    options.codex = true;
    options.claude = true;
  }

  return options;
}

function readValue(args, index, flag) {
  const value = args[index + 1];
  if (!value || value.startsWith("-")) {
    throw new Error(`${flag} requires a path value`);
  }
  return path.resolve(value);
}

function copyDirectory(source, destination, dryRun) {
  if (dryRun) {
    console.log(`[dry-run] copy directory ${source} -> ${destination}`);
    return;
  }

  fs.rmSync(destination, { recursive: true, force: true });
  fs.mkdirSync(path.dirname(destination), { recursive: true });
  fs.cpSync(source, destination, { recursive: true });
}

function copyFile(source, destination, dryRun) {
  if (dryRun) {
    console.log(`[dry-run] copy file ${source} -> ${destination}`);
    return;
  }

  fs.mkdirSync(path.dirname(destination), { recursive: true });
  fs.copyFileSync(source, destination);
}

function installCodex(options) {
  const source = path.join(packageRoot, "skills", "splat-cli");
  const destination = path.join(options.codexHome, "skills", "splat-cli");

  copyDirectory(source, destination, options.dryRun);
  console.log(`Installed Codex skill to ${destination}`);
}

function installClaude(options) {
  const commandSource = path.join(packageRoot, "claude", "commands", "splat.md");
  const snippetSource = path.join(packageRoot, "claude", "CLAUDE.md.snippet");
  const commandDestination = path.join(options.claudeHome, "commands", "splat.md");
  const snippetDestination = path.join(options.claudeHome, "SPLAT_CLAUDE.md");

  copyFile(commandSource, commandDestination, options.dryRun);
  copyFile(snippetSource, snippetDestination, options.dryRun);
  console.log(`Installed Claude command to ${commandDestination}`);
  console.log(`Installed Claude memory snippet to ${snippetDestination}`);
}

function main() {
  const options = parseArgs(process.argv.slice(2));

  if (options.command === "help") {
    printHelp();
    return;
  }

  if (options.command !== "install") {
    throw new Error(`Unknown command: ${options.command}`);
  }

  if (options.codex) {
    installCodex(options);
  }

  if (options.claude) {
    installClaude(options);
  }

  console.log("Done. Restart Codex or Claude Code if the new guidance is not discovered immediately.");
}

try {
  main();
} catch (error) {
  console.error(error instanceof Error ? error.message : String(error));
  process.exit(1);
}
