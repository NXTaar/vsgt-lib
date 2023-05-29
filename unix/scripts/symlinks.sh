#!/bin/bash

get_abs_filename() {
  echo "$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
}

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" || exit ; pwd -P )

cd "$parent_path" || exit

ln -s $(get_abs_filename "../zsh/.zshrc") ~/.zshrc
echo .zshrc symlink ✅

ln -s $(get_abs_filename "../zsh/.antigenrc") ~/.antigenrc
echo .antigenrc symlink ✅

ln -s $(get_abs_filename "../zsh/.p10k.zsh") ~/.p10k.zsh
echo terminal theme symlink ✅

mkdir -p ~/.config
ln -s $(get_abs_filename "../nvim") ~/.config/nvim
echo Neovim configuration folder symlink ✅

ln -s $(get_abs_filename "../tmux/.tmux.conf") ~/.tmux.conf
echo tmux config symlink ✅

ln -s $(get_abs_filename "../tmux/flags.sh") ~/.tmux/flags.sh
chmod u+x ~/.tmux/flags.sh 
echo tmux flags file symlink ✅

ln -s $(get_abs_filename "../zsh/svgo.config.js") ~/.svgoconfig
echo svgo config symlink ✅
