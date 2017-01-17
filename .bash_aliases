# Aliases

alias ..='cd ..'
alias c='clear'
alias ls='ls --color=auto'
alias ll='ls -lah'
alias grep='grep --color=auto'

## Emacs
alias emacscn="emacsclient -c -n"
alias emacsnw="emacsclient -nw"
alias kill-emacs="emacsclient -e '(kill-emacs)'"
alias restart-emacs="emacsclient -e '(kill-emacs)' && emacs --daemon"

## Misc
alias db="dropbox"
alias get-ip='wget http://ipinfo.io/ip -qO -'
