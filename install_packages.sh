#!/usr/bin/env bash

# Check if yay is installed, otherwise use pacman
if command -v yay &> /dev/null
then
    INSTALL_CMD="yay -S --noconfirm"
else
    INSTALL_CMD="sudo pacman -S --noconfirm"
fi

# Read packages.txt and install each package
while IFS= read -r package
do
    $INSTALL_CMD $package
done < packages.txt
