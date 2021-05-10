#!/bin/bash

function copy_to_config() {
	cp -R ./config/$1 $HOME/.config/
}

if command -v yay &> /dev/null; then
	yay -S zsh git curl neovim-git nvim-packer-git node npm lua-language-server python-pywal feh
fi

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

copy_to_config i3
copy_to_config i3status-rust
copy_to_config nvim
copy_to_config rofi

sed -i "s/bash/zsh/g" ~/.config/nvim/lua/mappings.lua

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
    mkdir -p ${LSP_BIN_PATH}
    curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-$(get_platform) -o ~/.local/bin/rust-analyzer
    chmod +x ~/.local/bin/rust-analyzer
    warn_path=true
  else
    echo "rust analyzer already installed"
fi

nvim +PackerInstall

