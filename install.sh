#!/bin/bash

function copy_to_config() {
	cp -R ./config/$1 $HOME/.config/
}

get_platform() {
  case "$(uname -s)" in
  Linux*) platform=Linux ;;
  Darwin*) platform=Mac ;;
  CYGWIN*) platform=Cygwin ;;
  MINGW*) platform=MinGw ;;
  *) platform="UNKNOWN:${unameOut}" ;;
  esac
  echo $platform
}

if command -v yay &> /dev/null; then
  yay -R vim
  yay -S zsh git curl neovim-git neovim-symlinks nvim-packer-git npm lua-language-server python-pywal feh rofi i3-gaps i3status-rust

  # Extras
  yay -S zsh-theme-powerlevel10k powerline-fonts awesome-terminal-fonts
fi

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

copy_to_config i3
copy_to_config i3status-rust
copy_to_config nvim
copy_to_config rofi

sed -i "s/bash/zsh/g" $HOME/.config/nvim/lua/mappings.lua

echo 'PATH="$HOME/.local/bin:$PATH"' > $HOME/.profile
echo 'export npm_config_prefix="$HOME/.local"' >> $HOME/.profile
echo 'source ~/.profile' >> $HOME/.zshrc

. $HOME/.profile

install_node_deps() {
  if [[ -z $(which npm) ]]; then
    echo "npm not installed"
    return
  fi
  npm install -g $@
}

install_node_deps typescript typescript-language-server prettier
install_node_deps vscode-html-languageserver-bin
install_node_deps vscode-css-languageserver-bin
install_node_deps vscode-json-languageserver
install_node_deps pyright
install_node_deps bash-language-server

if [[ ! -e ~/.local/bin/rust-analyzer ]]; then
    mkdir -p $HOME/.local/bin 
    curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-$(get_platform) -o ~/.local/bin/rust-analyzer
    chmod +x ~/.local/bin/rust-analyzer
    warn_path=true
  else
    echo "rust analyzer already installed"
fi

nvim +PackerInstall

cp .wallpaper.jpg $HOME/.wallpaper.jpg
wal -i $HOME/.wallpaper.jpg

