# .bashrc configuration

## Environment Variables
export PS1="\[\033[38;5;39m\]\u@\H\[$(tput sgr0)\]\[\033[38;5;84m\] \e[97min \e[32m\w\[$(tput sgr0)\]\[\033[38;5;15m\]\n\\$\[$(tput sgr0)\] "
export TERM='xterm-256color'
export EDITOR="emacsclient -nw --alternate-editor=vim"

if [ -d "$HOME/bin/" ]; then
    export PATH=$HOME/bin:$PATH
fi

school=~/Dropbox/School/2017/spring
if [ -d "$school" ]; then
    export school
fi

## Functions

extract() {
    if [ -z "$1" ]; then
	# display usage if no parameters given
	echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    else
	if [ -f "$1" ] ; then
            NAME=${1%.*}
	    echo $NAME
            mkdir $NAME && cd $NAME
            case "$1" in
		*.tar.bz2|*.tar.gz|*.tar.xz|*.tar|*.tgz|*.tbz2)   tar xvf ../$1    ;;
		*.lzma)      unlzma ../$1      ;;
		*.bz2)       bunzip2 ../$1     ;;
		*.rar)       unrar x -ad ../$1 ;;
		*.gz)        gunzip ../$1      ;;
		*.zip)       unzip ../$1       ;;
		*.Z)         uncompress ../$1  ;;
		*.7z)        7z x ../$1        ;;
		*.xz)        unxz ../$1        ;;
		*.exe)       cabextract ../$1  ;;
		*)           extract: echo "'$1' - unknown archive method" >&2 ;;
            esac
	else
            echo "$1 - file does not exist" >&2
	fi
    fi
}

bak() {
    if [ "$#" -eq 0 ]; then
	echo "Usage: bak <file>"
    fi

    for file in "$@"
    do
	if [ -e "$file" ] && [ -f "$file" ]; then
	    cp $file{,.bak}
	else
	    echo "$file does not exist" >&2
	fi
    done
}
