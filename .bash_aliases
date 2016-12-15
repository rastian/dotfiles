# Misc
alias open="xdg-open"
alias db="dropbox"
alias get-ip='wget http://ipinfo.io/ip -qO -'

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
