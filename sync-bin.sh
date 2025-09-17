source ./backup.sh
source ./path-append.sh

target="$HOME/bin"
source_dir="$PWD/bin"

find ./bin -type f -exec chmod +x {} +

if [ -e "$target" ]; then
	if [ -L "$target" ]; then
		# It's a symlink
		link_target=$(readlink "$target")
		if [ "$link_target" = "$source_dir" ]; then
			echo "-----> $target is already correctly symlinked to $source_dir. Nothing to do."
		else
			echo "Warning: $target is a symlink to $link_target."
			read -p "Do you want to replace this symlink with one to $source_dir? [y/N] " confirm
			if [[ "$confirm" =~ ^[Yy]$ ]]; then
				rm "$target"
				ln -s "$source_dir" "$target"
				echo "-----> Replaced symlink $target -> $source_dir"
			else
				echo "-----> Skipping symlink replacement."
			fi
		fi
	else
		# It's a real directory or file
		echo "Warning: $target exists and is not a symlink."
		read -p "Do you want to back it up and replace it with a symlink to $source_dir? [y/N] " confirm
		if [[ "$confirm" =~ ^[Yy]$ ]]; then
			backup "$target"
			ln -s "$source_dir" "$target"
			echo "-----> Backed up and symlinked $target -> $source_dir"
		else
			echo "-----> Skipping replacement."
		fi
	fi
else
	ln -s "$source_dir" "$target"
	echo "-----> Symlinked $target -> $source_dir"
fi
