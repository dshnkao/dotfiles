export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/Sync/scripts:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.cabal/bin:$PATH"
export PATH="$HOME/Sync/scripts:$PATH"

export FPATH="$HOME/.zsh/zfunc:$FPATH"


case $(uname) in
    'Linux')
        export JAVA_HOME="/usr/lib/jvm/java-1.8.0-openjdk-amd64"
        export JDK_HOME="/usr/lib/jvm/java-1.8.0-openjdk-amd64"
        ;;
    'Darwin')
        export JAVA_HOME=$(/usr/libexec/java_home)
        ;;
esac

#typeset -A ZSH_HIGHLIGHT_STYLES
#ZSH_HIGHLIGHT_STYLES[globbing]='none'
#ZSH_HIGHLIGHT_STYLES[alias]='none'
#ZSH_HIGHLIGHT_STYLES[command]='none'
#ZSH_HIGHLIGHT_STYLES[builtin]='none'
#ZSH_HIGHLIGHT_STYLES[function]='none'

# ubuntu apt-get
[ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# mac brew
[ -f /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# mac
[ -f ~/Drive/code/projects/zsh-git-prompt/zshrc.sh ] && source ~/Drive/code/projects/zsh-git-prompt/zshrc.sh
# linux
[ -f ~/repos/my/zsh-git-prompt/zshrc.sh ] && source ~/repos/my/zsh-git-prompt/zshrc.sh
