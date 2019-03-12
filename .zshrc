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
# share history for multiple shells
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
# remove command from history if prepended by space
setopt histignorespace
# emacs mode
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

# alias
alias ...="cd ../.."
alias ..="cd .."
alias bctl='bluetoothctl'
alias grep="grep --color=auto"
alias hibernate='systemctl hibernate'
alias nrs='sudo nixos-rebuild switch'
alias passf='pass $(fzf-password-store.sh)'
alias r='ranger'
alias se='sudoedit'
alias t='tmux'
alias vi="nvim"
alias vt='nvim -c terminal -u ~/.vimrc-term'
alias lx='exa --group-directories-first --git --sort=extension'
alias l='lx -l'
alias ll='lx -al'
alias f="firefox-open.sh ${FIREFOX_DB} "fzf --no-sort --exact""
alias ff="firefox-open.sh ${FIREFOX_DB} "rofi -dmenu -i -p url --no-sort""
# docker
alias docker-rmi-all='docker images -q -a | xargs --no-run-if-empty docker rmi'
alias docker-rm-exited='docker rm $(docker ps -q -f status=exited)'
alias docker-run-ubuntu='docker run -dit ubuntu'

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

# change directory using fzf
function cdf() {
    local dir=$(cat <(echo "..") <(find . -maxdepth 1 -type d) | fzf)
    [ "$dir" != "" ] && cd "$dir"
}
# remote edit file using local vi
function viscp () { 
    vi scp://"$1"/"$2" 
}
# add all ssh keys
function ssh-add-all() {
    find ~/.ssh/ -regex '.*id_rsa.*' | grep -v pub | xargs ssh-add
}
# cd into a project using emacs-projectile-bookmark and fzf
function jj() {
    local data=$(cat ~/.emacs.d/projectile-bookmarks.eld)
    local dir=$(echo $data | \
        sed -e 's/^(//' \
        -e 's/)$//' \
        -e "s#~#$HOME#g" \
        -e 's/" "/"\n"/g' \
        -e 's/"//g' | fzf --exact)
    [ "$dir" != "" ] && cd "$dir"
    zle reset-prompt &> /dev/null
}
zle -N jj
bindkey '^j' jj

function wiki() {
    local org=$(fd . ~/repos/my/wiki -t f -x basename | sort --reverse | fzf --exact)
    bat "$HOME/repos/my/wiki/$org"
}

# password-store tab complete
autoload -Uz _pass
# iterm2
include "$HOME/.iterm2_shell_integration.zsh"
# fzf
include "$HOME/.fzf.zsh"
include "$(fzf-share 2>/dev/null)/key-bindings.zsh"
export FZF_CTRL_R_OPTS='--exact'
# autojump
include "/usr/local/etc/profile.d/autojump.sh"
include "/run/current-system/sw/share/autojump/autojump.zsh"
# zsh syntax highlighting
include "/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
include "/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

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
