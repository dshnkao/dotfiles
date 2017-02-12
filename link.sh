#!/bin/bash

## ln all dotfiles in dotfiles dir

dotfiles=~/linux_dotfiles/*
for src in $dotfiles; do
    f=$(basename "$src")
    target="$HOME/.$f"
    ln -sfn $src $target
done

# neovim
ln -sfn ~/linux_dotfiles/vimrc ~/.config/nvim/init.vim

