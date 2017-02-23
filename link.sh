#!/usr/bin/env sh

## ln all dotfiles in dotfiles dir

dotfiles=~/dotfiles/*
for src in $dotfiles; do
    f=$(basename "$src")
    target="$HOME/.$f"
    ln -sfn $src $target
done

# neovim
mkdir ~/.config/nvim
ln -sfn ~/dotfiles/vimrc ~/.config/nvim/init.vim

