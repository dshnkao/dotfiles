export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/repos/my/scripts:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cabal/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.npm/bin:$PATH"

export FPATH="$HOME/.zsh/zfunc:$FPATH"


case $(uname) in
    'Linux')
        #export JAVA_HOME="/usr/lib/jvm/java-1.8.0-openjdk-amd64"
        #export JDK_HOME="/usr/lib/jvm/java-1.8.0-openjdk-amd64"
        #NIX_LINK="$HOME/.nix-profile"
        #export LD_LIBRARY_PATH="$NIX_LINK"/lib
        ;;
    'Darwin')
        export JAVA_HOME=$(/usr/libexec/java_home)
        ;;
esac

