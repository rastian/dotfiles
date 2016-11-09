# Misc
alias open="xdg-open"
alias db="dropbox"
alias synaptic="sudo synaptic"
alias wiki="python3 ~/Dropbox/Projects/wiki-cli/wiki.py"
alias todo="python3 ~/Dropbox/Projects/todo/todo.py"
alias eclipse="$HOME/.eclipse/eclipse"
alias update='sudo apt-get update && sudo apt-get upgrade'

# Movement
alias .='cd ..'
alias ..='cd ../..'
alias ...='cd ../../..'
alias ....='cd ../../../..'
alias c='clear'

# Emacs
alias emacscn="emacsclient -c -n"
alias emacsnw="emacsclient -nw"
alias kill-emacs="emacsclient -e '(kill-emacs)'"
alias restart-emacs="emacsclient -e '(kill-emacs)' && emacs --daemon"
