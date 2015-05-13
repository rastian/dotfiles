gitDir=~/git/dotfiles

DIRS=".emacs.d/ .config/i3/ .config/i3blocks/ .config/ranger .config/beets"
FILES=".bashrc .Xresources bash_aliases compton.conf"

for dir in $DIRS
do
		if [ ! -e "$HOME/$dir" ]
		then
				echo "$dir does not exist."; echo continue
		else
				cp -r $HOME/$dir $gitDir/${dir#".config ."}
				echo "Moved ${dir}..."
		fi
done
