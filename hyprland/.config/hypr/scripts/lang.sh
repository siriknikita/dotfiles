#!/usr/bin/env bash

icon="$HOME/Pictures/icons/2024-11-06-191142_hyprshot.png"

# Get language
get_lang() {
	lang=$(hyprctl devices -j | gojq -r '.keyboards[] | select(.name == "asus-keyboard") | .active_keymap' | cut -c 1-2 | tr 'A-Z' 'a-z')
	case $lang in
		en)
			lang="English language"
			;;
		uk)
			lang="Українська мова"
			;;
		ru)
			lang="Русский язык"
			;;
	esac
	echo $lang
}

# Notify
notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -i "$icon" "$(get_lang)"
