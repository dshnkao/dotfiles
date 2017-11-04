# export TERM=xterm-256color
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
# systemd deletes /run/users/:id/gnpug on logout
gpgconf --create-socketdir > /dev/null 2>&1

[ -f ~/repos/my/zsh-git-prompt/zshrc.sh ] && source ~/repos/my/zsh-git-prompt/zshrc.sh
# prompt
autoload -U colors && colors
GIT_PROMPT_EXECUTABLE="haskell"
##PS1="%{$fg[blue]%}%m %{$reset_color%}%2c%{$reset_color%}> % "
#PROMPT='[%F{blue}%n%f@%F{blue}%m%f] '
PROMPT='[%F{blue}%n%f@%F{blue}%m%f %F{yellow}%1~%f] '
RPROMPT='$(git_super_status)'

# alias
alias ...="cd ../.."
alias ..="cd .."
alias confnix='sudoedit /etc/nixos/configuration.nix'
alias gitdelmerged='git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d'
alias grep="grep --color=auto"
alias gst='git status -sb'
alias hibernate='systemctl hibernate'
alias nrs='sudo nixos-rebuild switch'
alias open='rifle'
alias passf='pass $(passfzf.sh)'
alias r='ranger'
alias se='sudoedit'
alias ssh='TERM=xterm-256color ssh'
alias vim="nvim"
alias vt='nvim -c terminal -u ~/.vimrc-term'
case $(uname) in
  'Linux')
      alias ls="ls -X --color"
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
# autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && source /usr/local/etc/profile.d/autojump.sh

[ -f /run/current-system/sw/share/autojump/autojump.zsh ] && source  /run/current-system/sw/share/autojump/autojump.zsh
