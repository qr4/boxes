#!/usr/bin/bash

git clone https://aur.archlinux.org/yay.git
pushd yay
makepkg -si --noconfirm
popd
rm -rf yay

yay -Syu

echo "Setting up zsh..."
yay -S --noconfirm oh-my-zsh-git

# needs sudo to work passwordless
sudo chsh -s $(which zsh) $(whoami)

yay -S --noconfirm pwnat
yay -S --noconfirm gef-git
yay -S --noconfirm python2-pwntools-git

echo "Setting up pwndbg..."
echo "source /usr/share/pwndbg/gdbinit.py" > ~/.gdbinit
