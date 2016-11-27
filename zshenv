export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/scripts:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.cabal/bin:$PATH"
#export GOPATH="$HOME/Drive/go"
#export PATH="$PATH:/usr/local/go/bin"
#export GOBIN="$GOPATH/bin"

## zsh-syntax-highlighting
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[globbing]='none'
ZSH_HIGHLIGHT_STYLES[alias]='none'
ZSH_HIGHLIGHT_STYLES[command]='none'
ZSH_HIGHLIGHT_STYLES[builtin]='none'
ZSH_HIGHLIGHT_STYLES[function]='none'
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

