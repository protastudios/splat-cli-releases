#!/usr/bin/env bash
set -euo pipefail

REPO_SLUG="${SPLAT_INSTALL_REPO:-protastudios/splat-cli-releases}"
INSTALL_DIR="${SPLAT_INSTALL_DIR:-$HOME/.local/bin}"
OUTPUT_PATH="${INSTALL_DIR}/splat"
ARCHIVE_PATH_OVERRIDE="${SPLAT_INSTALL_ARCHIVE_PATH:-}"
ARCHIVE_URL_OVERRIDE="${SPLAT_INSTALL_ARCHIVE_URL:-}"
RELEASE_TAG_OVERRIDE="${SPLAT_INSTALL_VERSION:-}"

require_cmd() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "Missing required command: $1" >&2
    exit 1
  fi
}

normalize_os() {
  case "$1" in
    Darwin) echo "darwin" ;;
    Linux) echo "linux" ;;
    MINGW*|MSYS*|CYGWIN*) echo "windows" ;;
    *) echo "" ;;
  esac
}

normalize_arch() {
  case "$1" in
    arm64|aarch64) echo "arm64" ;;
    x86_64|amd64) echo "x64" ;;
    *) echo "" ;;
  esac
}

target_slug_for_host() {
  local os_name="$1"
  local arch_name="$2"

  case "${os_name}:${arch_name}" in
    darwin:arm64) echo "darwin_arm64" ;;
    darwin:x64) echo "darwin_x64" ;;
    linux:x64) echo "linux_x64_baseline" ;;
    linux:arm64) echo "linux_arm64" ;;
    windows:x64) echo "windows_x64" ;;
    *)
      echo "" ;;
  esac
}

archive_ext_for_target() {
  case "$1" in
    windows_*) echo "zip" ;;
    *) echo "tar.gz" ;;
  esac
}

extract_archive() {
  local archive_path="$1"
  local extract_dir="$2"

  case "${archive_path}" in
    *.zip)
      require_cmd unzip
      unzip -q "${archive_path}" -d "${extract_dir}"
      ;;
    *.tar.gz)
      tar -xzf "${archive_path}" -C "${extract_dir}"
      ;;
    *)
      echo "Unsupported archive type: ${archive_path}" >&2
      exit 1
      ;;
  esac
}

repair_macos_signature() {
  local binary_path="$1"
  local file_info

  if [[ "$(uname -s)" != "Darwin" ]]; then
    return
  fi

  if ! command -v codesign >/dev/null 2>&1 || ! command -v file >/dev/null 2>&1; then
    return
  fi

  file_info="$(file "${binary_path}")"
  if [[ "${file_info}" != *"Mach-O"* ]]; then
    return
  fi

  codesign --remove-signature "${binary_path}" >/dev/null 2>&1 || true
  if ! codesign --force --sign - "${binary_path}" >/dev/null 2>&1; then
    echo "Warning: could not ad-hoc sign installed macOS binary at ${binary_path}" >&2
  fi
}

lookup_asset_url() {
  local repo_slug="$1"
  local asset_name="$2"
  local release_tag="$3"
  local api_url
  local metadata
  local download_url

  require_cmd curl

  if [[ -n "${release_tag}" ]]; then
    api_url="https://api.github.com/repos/${repo_slug}/releases/tags/${release_tag}"
  else
    api_url="https://api.github.com/repos/${repo_slug}/releases/latest"
  fi

  metadata="$(curl -fsSL "${api_url}")"
  download_url="$(printf '%s' "${metadata}" | tr ',' '\n' | grep "\"browser_download_url\"" | sed -E 's/.*"browser_download_url"[[:space:]]*:[[:space:]]*"([^"]+)".*/\1/' | grep "/${asset_name}$" | head -n 1 || true)"

  if [[ -z "${download_url}" ]]; then
    echo "Could not find release asset ${asset_name} in ${repo_slug}" >&2
    exit 1
  fi

  printf '%s' "${download_url}"
}

download_archive() {
  local url="$1"
  local output_path="$2"
  require_cmd curl
  curl -fsSL "${url}" -o "${output_path}"
}

main() {
  local os_name
  local arch_name
  local target_slug
  local archive_ext
  local temp_dir
  local archive_path
  local asset_name
  local download_url
  local installed_binary
  local metadata

  os_name="$(normalize_os "$(uname -s)")"
  arch_name="$(normalize_arch "$(uname -m)")"

  if [[ -z "${os_name}" || -z "${arch_name}" ]]; then
    echo "Unsupported platform: $(uname -s) $(uname -m)" >&2
    exit 1
  fi

  target_slug="$(target_slug_for_host "${os_name}" "${arch_name}")"
  if [[ -z "${target_slug}" ]]; then
    echo "No release target is configured for ${os_name}/${arch_name}" >&2
    exit 1
  fi

  archive_ext="$(archive_ext_for_target "${target_slug}")"

  temp_dir="$(mktemp -d)"
  trap "rm -rf '${temp_dir}'" EXIT

  archive_path="${temp_dir}/splat.${archive_ext}"

  if [[ -n "${ARCHIVE_PATH_OVERRIDE}" ]]; then
    cp "${ARCHIVE_PATH_OVERRIDE}" "${archive_path}"
  else
    if [[ -n "${ARCHIVE_URL_OVERRIDE}" ]]; then
      download_url="${ARCHIVE_URL_OVERRIDE}"
    else
      asset_name=""
      if [[ -n "${RELEASE_TAG_OVERRIDE}" ]]; then
        asset_name="splat_${RELEASE_TAG_OVERRIDE#v}_${target_slug}.${archive_ext}"
      else
        asset_name="splat_"
      fi

      if [[ -n "${RELEASE_TAG_OVERRIDE}" ]]; then
        download_url="$(lookup_asset_url "${REPO_SLUG}" "${asset_name}" "${RELEASE_TAG_OVERRIDE}")"
      else
        require_cmd curl
        metadata="$(curl -fsSL "https://api.github.com/repos/${REPO_SLUG}/releases/latest")"
        download_url="$(printf '%s' "${metadata}" | tr ',' '\n' | grep "\"browser_download_url\"" | sed -E 's/.*"browser_download_url"[[:space:]]*:[[:space:]]*"([^"]+)".*/\1/' | grep "_${target_slug}\\.${archive_ext}$" | head -n 1 || true)"
        if [[ -z "${download_url}" ]]; then
          echo "Could not find a latest release asset for ${target_slug}" >&2
          exit 1
        fi
      fi
    fi

    download_archive "${download_url}" "${archive_path}"
  fi

  extract_archive "${archive_path}" "${temp_dir}"

  installed_binary="$(find "${temp_dir}" -type f \( -name 'splat' -o -name 'splat.exe' \) | head -n 1 || true)"
  if [[ -z "${installed_binary}" ]]; then
    echo "Could not find splat binary inside downloaded archive" >&2
    exit 1
  fi

  mkdir -p "${INSTALL_DIR}"
  cp "${installed_binary}" "${OUTPUT_PATH}"
  chmod +x "${OUTPUT_PATH}" || true
  repair_macos_signature "${OUTPUT_PATH}"

  cat <<EOF
Installed splat to:
  ${OUTPUT_PATH}

Detected target:
  ${target_slug}

If "${INSTALL_DIR}" is not on your PATH, add this to your shell profile:
  export PATH="${INSTALL_DIR}:\$PATH"

Next:
  splat --help
  splat auth
EOF
}

main "$@"
