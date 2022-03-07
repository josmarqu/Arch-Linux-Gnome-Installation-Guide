#!/bin/bash
sudo pacman -S base-devel
sudo pacman -S git
cd /var/cache/pacman/pkg 
sudo mkdir /var/cache/pacman/pkg/yay
sudo chmod 777 /var/cache/pacman/pkg/yay
git clone https://aur.archlinux.org/yay.git
cd /var/cache/pacman/pkg/yay
makepkg -si
yay -Syy pamac-aur-git
sudo pacman -S gnome 
sudo systemctl enable gdm.service
sudo reboot