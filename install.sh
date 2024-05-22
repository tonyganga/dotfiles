#!/usr/bin/env bash
# vim: filetype=sh
VIM_PLUGINS="
tpope/vim-fugitive
tpope/vim-unimpaired
tpope/vim-surround
scrooloose/nerdtree
scrooloose/nerdcommenter
kien/ctrlp.vim
rking/ag.vim
majutsushi/tagbar
milkypostman/vim-togglelist
vim-airline/vim-airline
vim-airline/vim-airline-themes
elzr/vim-json
fatih/vim-go
avakhov/vim-yaml
ludovicchabant/vim-gutentags
valloric/youcompleteme
airblade/vim-gitgutter
Xuyuanp/nerdtree-git-plugin
hashivim/vim-terraform
plasticboy/vim-markdown
godlygeek/tabular
morhetz/gruvbox
junegunn/fzf.vim
rust-lang/rust.vim
racer-rust/vim-racer
"

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "Homebrew is not installed. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "Homebrew installed successfully!"
else
    echo "Homebrew is already installed."
fi

# Check if Oh My Zsh is installed
if [ ! -d ~/.oh-my-zsh ]; then
    echo "Oh My Zsh is not installed. Installing..."
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    echo "Oh My Zsh installed successfully!"
else
    echo "Oh My Zsh is already installed."
fi

mkdir -p ~/.vim/autoload ~/.vim/bundle
# make sure we have pathogen
if [ ! -e ~/.vim/autoload/pathogen.vim ]; then
  curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
fi
# install all the plugins
for plugin in $VIM_PLUGINS; do
  plugin_name="${plugin##*/}"
  echo
  if [ ! -d $HOME/.vim/bundle/$plugin_name ]; then
    echo "VIM-PLUGINS: $plugin not found. Installing"
    git clone --recurse-submodules --depth=1 "https://github.com/$plugin" "$HOME/.vim/bundle/$plugin_name"
  else
    echo "VIM-PLUGINS: $plugin found. Checking for updates"
    cd "$HOME/.vim/bundle/$plugin_name" && git pull
  fi
done
