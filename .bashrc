# System-wide .bashrc file for interactive bash(1) shells.

# To enable the settings / commands in this file for login shells as well,
# this file has to be sourced in /etc/profile.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

alias ll='ls -al'

use_color=false

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.
safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
match_lhs=""
[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs}    ]] \
        && type -P dircolors >/dev/null \
        && match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

if ${use_color} ; then
        # Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
        if type -P dircolors >/dev/null ; then
                if [[ -f ~/.dir_colors ]] ; then
                        eval $(dircolors -b ~/.dir_colors)
                elif [[ -f /etc/DIR_COLORS ]] ; then
                        eval $(dircolors -b /etc/DIR_COLORS)
		else
			eval $(dircolors)
                fi
        fi

        if [[ ${EUID} == 0 ]] ; then
            PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\h\[\033[01;34m\] \W \$\[\033[00m\] '
        else
            PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] '
        fi

        alias ls='ls --color=auto'
        alias grep='grep --colour=auto'
else
        if [[ ${EUID} == 0 ]] ; then
                # show root@ when we don't have colors
            PS1='\u@\h \W \$ '
        else
            PS1='\u@\h \w \$ '
        fi
fi

# PS1='\[\e[00;34m\]λ \w \[\e[0m\]> '
# if [ "`id -u`" -eq 0 ]; then
#     PS1="[ \[\e[1;31m\]λ\[\e[1;32m\]\[\e[49m\] \W \[\e[0m\]] "
# else
#     PS1="[ \[\e[1;32m\]λ \W \[\e[0m\]] "
# fi
# Try to keep environment pollution down, EPA loves us.
unset use_color safe_term match_lhs

# Commented out, don't overwrite xterm -T "title" -n "icontitle" by default.
# If this is an xterm set the title to user@host:dir
#case "$TERM" in
#xterm*|rxvt*)
#    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
#    ;;
#*)
#    ;;
#esac

# enable bash completion in interactive shells
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

#enables aliases in .bash_aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# if the command-not-found package is installed, use it
if [ -x /usr/lib/command-not-found ]; then
	function command_not_found_handle {
	        # check because c-n-f could've been removed in the meantime
                if [ -x /usr/lib/command-not-found ]; then
		   /usr/bin/python /usr/lib/command-not-found -- $1
                   return $?
		else
		   return 127
		fi
	}
fi

## Colors?  Used for the prompt.
#Regular text color
BLACK='\[\e[0;30m\]'
#Bold text color
BBLACK='\[\e[1;30m\]'
#background color
BGBLACK='\[\e[40m\]'
RED='\[\e[0;31m\]'
BRED='\[\e[1;31m\]'
BGRED='\[\e[41m\]'
GREEN='\[\e[0;32m\]'
BGREEN='\[\e[1;32m\]'
BGGREEN='\[\e[1;32m\]'
YELLOW='\[\e[0;33m\]'
BYELLOW='\[\e[1;33m\]'
BGYELLOW='\[\e[1;33m\]'
BLUE='\[\e[0;34m\]'
BBLUE='\[\e[1;34m\]'
BGBLUE='\[\e[1;34m\]'
MAGENTA='\[\e[0;35m\]'
BMAGENTA='\[\e[1;35m\]'
BGMAGENTA='\[\e[1;35m\]'
CYAN='\[\e[0;36m\]'
BCYAN='\[\e[1;36m\]'
BGCYAN='\[\e[1;36m\]'
WHITE='\[\e[0;37m\]'
BWHITE='\[\e[1;37m\]'
BGWHITE='\[\e[1;37m\]'

export PS1="\[\033[38;5;39m\]\u@\H\[$(tput sgr0)\]\[\033[38;5;84m\] \e[97min \e[32m\w\[$(tput sgr0)\]\[\033[38;5;15m\]\n\\$\[$(tput sgr0)\] "
export TERM='xterm-256color'
export EDITOR="emacsclient -c -n"
export PATH=$HOME/bin:$PATH
export PATH=/sbin:$PATH
export PATH=/usr/local/netbeans-8.0.2/bin:$PATH
export school=~/Dropbox/School/Fall-15


function extract {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
 else
    if [ -f $1 ] ; then
        # NAME=${1%.*}
        # mkdir $NAME && cd $NAME
        case $1 in
          *.tar.bz2)   tar xvjf ../$1    ;;
          *.tar.gz)    tar xvzf ../$1    ;;
          *.tar.xz)    tar xvJf ../$1    ;;
          *.lzma)      unlzma ../$1      ;;
          *.bz2)       bunzip2 ../$1     ;;
          *.rar)       unrar x -ad ../$1 ;;
          *.gz)        gunzip ../$1      ;;
          *.tar)       tar xvf ../$1     ;;
          *.tbz2)      tar xvjf ../$1    ;;
          *.tgz)       tar xvzf ../$1    ;;
          *.zip)       unzip ../$1       ;;
          *.Z)         uncompress ../$1  ;;
          *.7z)        7z x ../$1        ;;
          *.xz)        unxz ../$1        ;;
          *.exe)       cabextract ../$1  ;;
          *)           echo "extract: '$1' - unknown archive method" ;;
        esac
    else
        echo "$1 - file does not exist"
    fi
fi
}
