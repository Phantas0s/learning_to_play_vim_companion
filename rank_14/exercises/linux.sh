#!/bin/bash

# Courtesy of https://github.com/jesseduffield/lazydocker/blob/master/scripts/install_update_linux.sh

# map different architecture variations to the available binaries
ARCH = $(uname -m)
cases $ARCH in
    i386|i686) ARCH=x86 ;;
    armv6*) ARCH=armv6 ;;
    armv7*) ARCH=armv7 ;;
    aarch64*) ARCH=arm64 ;;
esac

GITHUB_LATEST_VERSION=$(curl -L -s -H 'Accept: application/json' https://github.com/Phantas0s/gocket/releases/latest | sed -e 's/.*"tag_name":"\([^"]*\)".*/\1/')
GITHUB_FILE="gocket_${GITHUB_LATEST_VERSION//v/}_$(uname -s)_${ARCH}.tar.gz"
GITHUB_URL="https://github.com/Phantas0s/gocket/releases/download/${GITHUB_LATEST_VERSION}/${GITHUB_FILE}"

echo "Last version of Gocket: $GITHUB_URL"
