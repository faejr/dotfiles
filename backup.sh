CONFIGDIR="$HOME/.config/"

function copy_config() {
	echo "Copying $1 config..."
	cp -R $CONFIGDIR/$1 config/
}

if [[ ! -d config ]]; then
	echo "Creating config dir..."
	mkdir config
else
	rm -rf config/*
fi

copy_config i3
copy_config i3status-rust
copy_config rofi
copy_config nvim

