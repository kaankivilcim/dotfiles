#!/bin/bash

set -eux
set -o pipefail

export DEBIAN_FRONTEND=noninteractive

# Check we're not root
if [[ "${EUID}" -eq 0 ]]; then
  echo "Run as normal user."
  exit
fi

copy_dotfiles() {
  (
  cd ..
  cp -r .config "${HOME}"
  cp .bash_profile "${HOME}"
  cp .bashrc "${HOME}"
  cp .i3status.conf "${HOME}"
  cp .tmux.conf "${HOME}"
  cp .vimrc "${HOME}"
  )
}

copy_desktop_dotfiles() {
  (
  cd ..
  cp .Xmodmap "${HOME}"
  cp .xsessionrc "${HOME}"
  )
}

setup_sudo() {
  # Allow use of sudo without a password
  su -c "echo -e \"\\n$(whoami) ALL=(ALL) NOPASSWD:ALL\" >> /etc/sudoers"

  # Add user into useful systemd groups
  sudo gpasswd -a "$(whoami)" systemd-journal
  sudo gpasswd -a "$(whoami)" systemd-network
}

setup_home() {
  # Remove default home directories
  local -r DEFAULT_DIRS=(
    Music
    Pictures
    Public
    Templates
    Videos
  )
  for VAL in "${DEFAULT_DIRS[@]}"; do
    rm -rf ~/${VAL}
  done

  mkdir ~/Git

  copy_dotfiles
  copy_desktop_dotfiles
}

setup_alacritty() {
  # Install the Rust toolchain
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  source $HOME/.cargo/env

  sudo apt install -y \
    cmake \
    pkg-config \
    libfreetype6-dev \
    libfontconfig1-dev \
    libxcb-xfixes0-dev \
    python3 \
    --no-install-recommends

  git clone https://github.com/alacritty/alacritty.git ~/Git/alacritty
  cd ~/Git/alacritty
  cargo build --release
  sudo cp target/release/alacritty /usr/local/bin
  sudo tic -xe alacritty,alacritty-direct extra/alacritty.info
}

setup_vim () {
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  vim +PluginInstall +qall

  sudo update-alternatives --install /usr/bin/vi vi "$(command -v vim)" 60
  sudo update-alternatives --auto vi
  sudo update-alternatives --install /usr/bin/editor editor "$(command -v vim)" 60
  sudo update-alternatives --auto editor
}

setup_i3() {
  # Dependencies from https://github.com/Airblader/i3/wiki/Building-from-source
  sudo apt install -y \
    dh-autoreconf \
    libev-dev \
    libpango1.0-dev \
    libpcre2-8-0 \
    libpcre2-dev \
    libstartup-notification0-dev \
    libxcb-cursor-dev \
    libxcb-icccm4-dev \
    libxcb-keysyms1-dev \
    libxcb-randr0-dev \
    libxcb-shape0 \
    libxcb-shape0-dev \
    libxcb-util0-dev \
    libxcb-xinerama0-dev \
    libxcb-xkb-dev \
    libxcb-xrm-dev \
    libxcb-xrm0 \
    libxcb1-dev \
    libxkbcommon-dev \
    libxkbcommon-x11-dev \
    libyajl-dev \
    make \
    meson \
    xcb \
    --no-install-recommends

  sudo apt install -y \
    i3status \
    rofi \
    xautolock \
    --no-install-recommends

  (
  git clone https://github.com/Airblader/i3.git ~/Git/i3-gaps
  cd ~/Git/i3-gaps
  mkdir -p build && cd build
  meson ..
  ninja
  sudo meson install
  )
}

setup_theme() {
  # Base16 for shells
  git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
  ln -s ~/.config/base16-shell/scripts/base16-flat.sh ~/.base16_theme

  # Base16 for Rofi
  git clone https://github.com/0xdec/base16-rofi.git ~/.config/base16-rofi
  mkdir -p ~/.local/share/rofi
  ln -s ~/.config/base16-rofi/themes ~/.local/share/rofi/themes

  # Hack font
  mkdir -p ~/.local/share/fonts
  wget -O /tmp/Hack-v3.003-ttf.zip https://github.com/source-foundry/Hack/releases/download/v3.003/Hack-v3.003-ttf.zip
  unzip /tmp/Hack-v3.003-ttf.zip -d ~/.local/share/fonts/
  fc-cache -f -v
}

setup_sudo
setup_home
setup_alacritty
setup_vim
setup_i3
setup_theme
