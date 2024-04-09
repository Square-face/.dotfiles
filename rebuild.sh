

pushd ~/dotfiles/
$EDITOR ~/dotfiles/

if git diff --quiet '*.nix'; then
    echo "No changes detected, exiting."
    popd
    exit 0
fi

git diff -U0 '*.nix'

echo -n "Rebuilding system..."
if sudo nixos-rebuild switch --flake ".#$1" &>.nixos-switch.log; then
	echo -e " Done!\n"
else
	echo ""
	cat .nixos-switch.log | grep --color error

	# this is needed otherwise the script would not start next time telling you "no changes detected"
	# (The weird patter is to include all subdirectories)
	git restore --staged ./**/*.nix

	if read -p "Open log? (y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
		cat .nixos-switch.log | nvim 	
	fi

	# Clean stuff and exit
	shopt -u globstar
	exit 1
fi

echo -n "Rebuilding configurations..."
if home-manager switch --flake . &>.home-switch.log; then
	echo -e " Done!\n"
else
	echo ""
	cat .home-switch.log | grep --color error

	# this is needed otherwise the script would not start next time telling you "no changes detected"
	# (The weird patter is to include all subdirectories)
	git restore --staged ./**/*.nix

	if read -p "Open log? (y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
		cat .home-switch.log | nvim 	
	fi

	# Clean stuff and exit
	shopt -u globstar
	exit 1
fi

current=$(nix-env --list-generations | grep current | awk '{print "revision " $1}')

echo -n "Rebuild for $current complete"

git commit -am "$current"

popd

notify-send -e "NixOS Rebuilt OK!" --icon=software-update-available
