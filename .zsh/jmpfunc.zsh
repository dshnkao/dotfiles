## jump function
export MARKPATH=$HOME/.marks
function jmp {
    cd -P "$MARKPATH/$1" 2>/dev/null || echo "No such mark: $1"
}
function marks {
    \ls -l "$MARKPATH" | tail -n +2 | sed 's/  / /g' | cut -d' ' -f9- | awk -F ' -> ' '{printf "%-10s -> %s\n", $1, $2}'
}
function unmark {
    rm -i "$MARKPATH/$1"
}
function mark {
    mkdir -p "$MARKPATH"; ln -s "$(pwd)" "$MARKPATH/$1"
}

## tab completion
function _completemarks() {
    reply=($(ls $MARKPATH))
}

compctl -K _completemarks jmp
compctl -K _completemarks unmark
