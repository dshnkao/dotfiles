# generated
zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
autoload -Uz compinit
compinit
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
bindkey -e
#

export EDITOR=nvim
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
export LS_COLORS='di=36:ln=1;31:so=37;40:pi=1;33:ex=35:bd=37;40:cd=37;40:su=37;40:sg=37;40:tw=32;40:ow=32;40:'
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# disable gpg gui passphrase
# export PINENTRY_USER_DATA="USE_CURSES=1"
export GPG_TTY=$(tty)
# systemd deletes /run/users/:id/gnpug on logout
# gpgconf --create-socketdir > /dev/null 2>&1

# prompt
autoload -U colors && colors
PROMPT='[%F{blue}%n%f@%F{blue}%m%f %F{yellow}%1~%f] '
RPROMPT=''
setopt prompt_sp

# remove command from history if prepended by space
setopt histignorespace

# alias
alias ...="cd ../.."
alias ..="cd .."
alias bctl='bluetoothctl'
alias confnix='sudoedit /etc/nixos/configuration.nix'
alias gitdelmerged='git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d'
alias grep="grep --color=auto"
alias gs='git status -sb'
alias gst='git status -sb'
alias hibernate='systemctl hibernate'
alias nrs='sudo nixos-rebuild switch'
alias passf='pass $(passfzf.sh)'
alias r='ranger'
alias se='sudoedit'
# alias ssh='TERM=xterm-256color ssh'
alias t='tmux'
alias vi="nvim"
alias vt='nvim -c terminal -u ~/.vimrc-term'
alias lx='exa --group-directories-first --git --sort=extension'
alias l='lx -l'
alias ll='lx -al'
alias haskellshell='nix-shell -p "haskell.packages.ghc821.ghcWithPackages (pkgs: with pkgs; [ cabal-install ])"'
alias nixhs='nix-env -f "<nixpkgs>" -qaP -A haskellPackages'
alias g='umenu ~/.mozilla/firefox/bl0ar52g.default-1507385104150/places.sqlite "fzf --no-sort --exact"'
# docker
alias docker_rmi_all='docker images -q -a | xargs --no-run-if-empty docker rmi'

case $(uname) in
  'Linux')
      #alias ls="ls -X --color"
      alias ect="emacsclient -nw"
      alias ecg="emacsclient -nc"
      alias xc="xclip -select c"
      alias ecga='emacsclient -t --eval "(org-agenda-list)" "(delete-other-windows)"'
      ;;
  'Darwin')
      alias ls="gls -X --color"
      alias emacs="/usr/local/bin/emacs"
      alias egui="open -a /Applications/Emacs.app -n"
      alias edm="/usr/local/opt/emacs-mac/bin/emacs --daemon"
      alias ecg="/usr/local/opt/emacs-mac/bin/emacsclient -nc"
      alias ect="/usr/local/opt/emacs-mac/bin/emacsclient -nw"
      ;;
esac

# functions
cdf() {
    local dir=$(cat <(echo "..") <(find . -maxdepth 1 -type d) | fzf)
    [ "$dir" != "" ] && cd "$dir"
}
include() { [[ -f "$1" ]] && source "$1" } # source if file exists
viscp () { vi scp://"$1"/"$2" } # remote edit file using local vi
ssh-cammy () {
    local ip=$(ec2-cammy.sh "$1" "$2")
    [ "$ip" != "" ] && ssh ubuntu@$ip
}

# password-store tab complete
autoload -Uz _pass
# iterm2
include "$HOME/.iterm2_shell_integration.zsh"
# fzf
include "$HOME/.fzf.zsh"
include "$(fzf-share 2>/dev/null)/key-bindings.zsh"
# autojump
include "/usr/local/etc/profile.d/autojump.sh"
include "/run/current-system/sw/share/autojump/autojump.zsh"
# zsh syntax highlighting
include "/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
include "/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
# cammy
include "$HOME/.cammyenv"
include "$HOME/.carbonenv"

 # emacs tramp
if [[ "$TERM" == "dumb" ]]
then
  unsetopt zle
  unsetopt prompt_cr
  unsetopt prompt_subst
  unfunction precmd
  unfunction preexec
  PS1='$ '
fi
