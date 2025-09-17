source ./backup.sh

for name in *; do
	if [ ! -d "$name" ]; then
		target="$HOME/.$name"
		if [[ ! "$name" =~ \.sh$ ]]; then
			echo "-----> Symlinking your new $name"
			backup "$target"

			if [ ! -e "$target" ]; then
				echo "-----> Symlinking your new $target"
				ln -s "$PWD/$name" "$target"
			fi
		fi
	fi
done
