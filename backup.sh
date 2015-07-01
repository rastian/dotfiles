#!/bin/bash

currDir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

files=".bashrc .bash_aliases .emacs.d .Xresources"

printf "Do you wish to (m)ove or (c)opy the files? "
read choice

case $choice in
		"c")
				echo "You chose copy!"
				printf "Files copied:\n"
				for file in $files; do
						printf "$HOME/$file \t -> $currDir/${file#.}\n"
						cp -r "$HOME/$file" "$currDir/"
				done
				;;
		"m")
				echo "You chose move!"
				printf "Files moved:\n"
				for file in $files; do
						printf "$HOME/$file \t -> $currDir/${file#.}\n"
						mv "$HOME/$file" "$currDir/"
				done
				;;
		*)
				echo "Choose (m)ove or (c)opy"
				exit
				;;
esac
