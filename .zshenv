export GOPATH="$HOME/.go"
export GOROOT="$HOME/.nix-profile/share/go"
export FPATH="$HOME/.zsh/zfunc:$FPATH"
path=(
    /usr/local/bin
    ~/.local/bin
    ~/.cabal/bin
    ~/.cargo/bin
    ~/.npm/bin
    ~/.gem/ruby/2.4.0/bin
    $GOPATH/bin
    $path
)

include() { [[ -f "$1" ]] && source "$1" } # source if file exists

include "$HOME/.tldr.env"
include "$HOME/.carbon.env"

case $(uname) in
    'Linux')
        ;;
    'Darwin')
        export JAVA_HOME=$(/usr/libexec/java_home)
        ;;
esac
