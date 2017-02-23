FPATH="$HOME/.zsh/zfunc:$FPATH"

export TERM=xterm-256color
export EDITOR=/usr/bin/nvim

export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
export LS_COLORS='di=36:ln=1;31:so=37;40:pi=1;33:ex=35:bd=37;40:cd=37;40:su=37;40:sg=37;40:tw=32;40:ow=32;40:'

# encoding
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# disable gpg gui passphrase
export PINENTRY_USER_DATA="USE_CURSES=1"

# prompt
autoload -U colors && colors
PS1="%{$fg[green]%}%m %{$reset_color%}%2c%{$reset_color%}> % "
RPROMPT=''

# alias
alias ..="cd .."
alias ...="cd ../.."
alias v=vi
alias vi=vim
alias vim="nvim"
alias grep="grep --color=auto"
alias gst="git status -sb"
case $(uname) in
  'Linux')   
      alias ls="ls -X --color" 
      alias ect="emacsclient -nw"
      alias ecg="emacsclient -nc"
      alias xclip="xclip -select c"
      ;;
  'Darwin')  
      alias ls="gls -X --color" 
      alias emacs="/usr/local/Cellar/emacs-mac/emacs-25.1-z-mac-6.1/bin/emacs"
      alias egui="open -a /Applications/Emacs.app -n $1"
      alias edm="/usr/local/Cellar/emacs-mac/emacs-25.1-z-mac-6.1/bin/emacs --daemon"
      alias ecg="/usr/local/Cellar/emacs-mac/emacs-25.1-z-mac-6.1/bin/emacsclient -nc"
      alias ect="/usr/local/Cellar/emacs-mac/emacs-25.1-z-mac-6.1/bin/emacsclient -nw"
      ;;
esac

# The following lines were added by compinstall
zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install

## autocomplete on history
source $HOME/.zsh/zsh-history-substring-search.zsh
# bind UP and DOWN arrow keys
#zmodload zsh/terminfo
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down    
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

# iterm2
[ -f ~/.iterm2_shell_integration.zsh ] && source ~/.iterm2_shell_integration.zsh
# fzf 
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# password-store tab complete
autoload -Uz _pass
# cammy
[ -f ~/.cammyenv ] && source ~/.cammyenv
# jmp function
[ -f ~/.zsh/jmpfunc.zsh ] && source ~/.zsh/jmpfunc.zsh

