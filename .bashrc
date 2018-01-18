export EDITOR=nvim

export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
export LS_COLORS='di=36:ln=1;31:so=37;40:pi=1;33:ex=35:bd=37;40:cd=37;40:su=37;40:sg=37;40:tw=32;40:ow=32;40:'

# encoding
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# disable gpg gui passphrase
#export PINENTRY_USER_DATA="USE_CURSES=1"
export GPG_TTY=$(tty)

# prompt
#PROMPT='[%F{blue}%n%f@%F{blue}%m%f %F{yellow}%1~%f] '
#RPROMPT=''

# alias
alias ...="cd ../.."
alias ..="cd .."
alias bctl='bluetoothctl'
alias confnix='sudoedit /etc/nixos/configuration.nix'
alias gitdelmerged='git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d'
alias grep="grep --color=auto"
alias gst='git status -sb'
alias hibernate='systemctl hibernate'
alias nrs='sudo nixos-rebuild switch'
alias passf='pass $(passfzf.sh)'
alias r='ranger'
alias se='sudoedit'
alias ssh='TERM=xterm-256color ssh'
alias t='tmux'
alias vim="nvim"
alias vt='nvim -c terminal -u ~/.vimrc-term'
alias lx='exa --group-directories-first --git --sort=extension'
alias l='lx -l'
alias ll='lx -al'
case $(uname) in
  'Linux')
      #alias ls="ls -X --color"
      alias vi=/usr/bin/vim
      alias ect="emacsclient -nw"
      alias ecg="emacsclient -nc"
      alias xc="xclip -select c"
      alias ecga='emacsclient -t --eval "(org-agenda-list)" "(delete-other-windows)"'
      ;;
  'Darwin')
      alias ls="gls -X --color"
      alias vi=/usr/local/bin/vim
      alias emacs="/usr/local/bin/emacs"
      alias egui="open -a /Applications/Emacs.app -n $1"
      alias edm="/usr/local/opt/emacs-mac/bin/emacs --daemon"
      alias ecg="/usr/local/opt/emacs-mac/bin/emacsclient -nc"
      alias ect="/usr/local/opt/emacs-mac/bin/emacsclient -nw"
      ;;
esac
