#!/usr/bin/env bash

# check for 1 argument and its an directory
if [ "$#" -ne 1 ] || ! [ -d "$1" ]; then
  echo "Usage: $0 directory" >&2
  exit 1
fi

dotdir=$(realpath "$1")

echo "This will replace your current dotfiles in your home directory"
read -r -p "Continue [y/n] "
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    files=(zsh zshrc zshenv vimrc vimrc-term config/ranger global-gitignore spacemacs.d gitconfig config/taffybar config/nixpkgs tmux.conf)
    case $(uname) in
        'Linux') files+=(xmonad Xresources) ;;
        'Darwin') files+=(config/karabiner) ;;
    esac
    for f in "${files[@]}"
    do
        echo "linking $dotdir/$f to $HOME/.$f"
        ln -sfn "$dotdir/$f" "$HOME/.$f"
    done

    echo "linking $HOME/.vimrc to ~/.config/nvim/init/vim"
    mkdir ~/.config/nvim
    ln -sfn "$HOME/.vimrc" ~/.config/nvim/init.vim

    echo "linking $dotdir/ghci.conf to $HOME/.ghc/gchi.conf"
    ln -sfn "$dotdir/ghci.conf" "$HOME/.ghc/ghci.conf"
else
    echo "aborted"
fi
