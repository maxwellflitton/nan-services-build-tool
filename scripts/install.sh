#!/bin/sh
# All rights reserved. MIT license.

set -e

if ! command -v unzip >/dev/null; then
	echo "Error: unzip is required to install dprint." 1>&2
	exit 1
fi

if [ "$OS" = "Windows_NT" ]; then
	target="x86_64-pc-windows-msvc"
else
	case $(uname -sm) in
	"Darwin x86_64") target="x86_64-apple-darwin" ;;
	"Darwin arm64") target="aarch64-apple-darwin" ;;
	"Linux aarch64") target="aarch64-unknown-linux-gnu" ;;
	*) target="x86_64-unknown-linux-gnu" ;;
	esac
fi

echo "installing ${target}"

if [ $# -eq 0 ]; then
	uri="https://github.com/maxwellflitton/nan-services-build-tool/releases/latest/download/build_tool-${target}.tar.gz"
else
	uri="https://github.com/maxwellflitton/nan-services-build-tool/releases/download/${1}/build_tool-${target}.tar.gz"
fi

install_dir="${NANOS_INSTALL:-$HOME/.nanos}"
bin_dir="$install_dir/bin"
exe="$bin_dir/build_tool"

if [ ! -d "$bin_dir" ]; then
	mkdir -p "$bin_dir"
fi

curl --fail --location --progress-bar --output "$exe.tar.gz" "$uri"


cd "$bin_dir"
tar -xzf "$exe.tar.gz"
chmod +x "$exe"
rm "$exe.tar.gz"

echo "nanos was installed successfully to $exe"
if command -v dprint >/dev/null; then
	echo "Run 'nanos --help' to get started"
else
	case $SHELL in
	/bin/zsh) shell_profile=".zshrc" ;;
	*) shell_profile=".bash_profile" ;;
	esac
	echo "Manually add the directory to your \$HOME/$shell_profile (or similar)"
	echo "  export NANOS_INSTALL=\"$install_dir\""
	echo "  export PATH=\"\$NANOS_INSTALL/bin:\$PATH\""
	# echo "Run '$exe --help' to get started"
fi
