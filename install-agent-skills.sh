#!/usr/bin/env bash
set -euo pipefail

SPLAT_SKILLS_REPO="${SPLAT_SKILLS_REPO:-protastudios/splat-cli-releases}"
SPLAT_SKILLS_BRANCH="${SPLAT_SKILLS_BRANCH:-main}"
SPLAT_INSTALL_CODEX="${SPLAT_INSTALL_CODEX:-1}"
SPLAT_INSTALL_CLAUDE="${SPLAT_INSTALL_CLAUDE:-1}"

raw_base="https://raw.githubusercontent.com/${SPLAT_SKILLS_REPO}/${SPLAT_SKILLS_BRANCH}"
tmp_dir="$(mktemp -d)"

cleanup() {
  rm -rf "${tmp_dir}"
}
trap cleanup EXIT

download() {
  local remote_path="$1"
  local local_path="$2"
  mkdir -p "$(dirname "${local_path}")"
  curl -fsSL "${raw_base}/${remote_path}" -o "${local_path}"
}

if [[ "${SPLAT_INSTALL_CODEX}" == "1" ]]; then
  codex_home="${CODEX_HOME:-${HOME}/.codex}"
  codex_skill_dir="${codex_home}/skills/splat-cli"

  download "skills/splat-cli/SKILL.md" "${tmp_dir}/codex/SKILL.md"
  download "skills/splat-cli/agents/openai.yaml" "${tmp_dir}/codex/agents/openai.yaml"
  download "skills/splat-cli/references/install.md" "${tmp_dir}/codex/references/install.md"
  download "skills/splat-cli/references/auth.md" "${tmp_dir}/codex/references/auth.md"
  download "skills/splat-cli/references/safety.md" "${tmp_dir}/codex/references/safety.md"
  download "skills/splat-cli/references/commands.md" "${tmp_dir}/codex/references/commands.md"

  rm -rf "${codex_skill_dir}"
  mkdir -p "$(dirname "${codex_skill_dir}")"
  cp -R "${tmp_dir}/codex" "${codex_skill_dir}"
  echo "Installed Codex skill to ${codex_skill_dir}"
fi

if [[ "${SPLAT_INSTALL_CLAUDE}" == "1" ]]; then
  claude_home="${CLAUDE_HOME:-${HOME}/.claude}"
  claude_command_dir="${claude_home}/commands"

  download "claude/commands/splat.md" "${tmp_dir}/claude/commands/splat.md"
  download "claude/CLAUDE.md.snippet" "${tmp_dir}/claude/CLAUDE.md.snippet"

  mkdir -p "${claude_command_dir}"
  cp "${tmp_dir}/claude/commands/splat.md" "${claude_command_dir}/splat.md"
  cp "${tmp_dir}/claude/CLAUDE.md.snippet" "${claude_home}/SPLAT_CLAUDE.md"
  echo "Installed Claude command to ${claude_command_dir}/splat.md"
  echo "Installed Claude memory snippet to ${claude_home}/SPLAT_CLAUDE.md"
fi

echo "Done. Restart Codex or Claude Code if the new guidance is not discovered immediately."
