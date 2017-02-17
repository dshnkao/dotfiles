#!/bin/bash

## ln all dotfiles in dotfiles dir

dotfiles=~/dotfiles/*
for src in $dotfiles; do
    f=$(basename "$src")
    target="$HOME/.$f"
    ln -sfn $src $target
done

# neovim
ln -sfn ~/dotfiles/vimrc ~/.config/nvim/init.vim

