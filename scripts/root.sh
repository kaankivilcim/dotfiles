#!/bin/bash

set -e
set -o pipefail

export DEBIAN_FRONTEND=noninteractive

# Check we're root
if [[ "${EUID}" -ne 0 ]]; then
  echo "Run as root."
  exit
fi

setup_apt() {
  # Disable translations for faster apt updates
  mkdir -p /etc/apt/apt.conf.d
  echo 'Acquire::Languages "none";' > /etc/apt/apt.conf.d/99translations

  apt update
  apt install -y \
    apt-transport-https \
    ca-certificates \
    lsb-release \
    --no-install-recommends

  # Set up apt sources
  local -r DEBIAN_REL="$(lsb_release -c -s)"
  cat <<-EOF >/etc/apt/sources.list
deb http://deb.debian.org/debian ${DEBIAN_REL} main contrib non-free
deb-src http://deb.debian.org/debian/ ${DEBIAN_REL} main contrib non-free

deb http://deb.debian.org/debian/ ${DEBIAN_REL}-updates main contrib non-free
deb-src http://deb.debian.org/debian/ ${DEBIAN_REL}-updates main contrib non-free

deb http://security.debian.org/ ${DEBIAN_REL}/updates main contrib non-free
deb-src http://security.debian.org/ ${DEBIAN_REL}/updates main contrib non-free
EOF
}

install_base() {
  apt update
  apt full-upgrade -y

  apt install -y \
    curl \
    firefox-esr \
    git \
    htop \
    imagemagick \
    nmap \
    scrot \
    tmux \
    unzip \
    vim \
    wget \
    zip \
    --no-install-recommends

  apt purge -y \
    modemmanager
}

cleanup() {
  apt autoremove
  apt clean
}

setup_apt
install_base
cleanup
