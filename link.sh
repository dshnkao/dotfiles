#!/usr/bin/env bash

# check for 1 argument and its an directory
if [ "$#" -ne 1 ] || ! [ -d "$1" ]; then
  echo "Usage: $0 directory" >&2
  exit 1
fi

dotdir=`realpath "$1"`

echo "This will replace your current dotfiles in your home directory"
read -p "Continue [y/n] " 
echo    
if [[ $REPLY =~ ^[Yy]$ ]]; then
    files=(zsh zshrc zshenv vimrc config/ranger global-gitignore spacemacs.d password-store ssh gnupg)
    case $(uname) in 
        'Linux') files+=(xmonad Xresources) ;;
        'Darwin') files+=(config/karabiner) ;;
    esac
    for f in ${files[@]} 
    do
        echo "linking $dotdir/$f to $HOME/.$f"
        ln -sfn $dotdir/$f $HOME/.$f
    done
    echo "linking ~/.config/nvim/init/vim to $HOME/.vimrc"
    mkdir ~/.config/nvim
    ln -sfn $HOME/.vimrc ~/.config/nvim/init.vim 
else
    echo "aborted"
fi



