export GOPATH="$HOME/.go"
export FPATH="$HOME/.zsh/zfunc:$FPATH"
path=(
    $path
    ~/repos/my/scripts
    ~/.local/bin
    ~/.local/bin
    ~/.cabal/bin
    ~/.cargo/bin
    ~/.npm/bin
    $GOPATH/bin
)

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

