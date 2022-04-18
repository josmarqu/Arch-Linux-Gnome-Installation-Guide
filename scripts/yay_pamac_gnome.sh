#!/bin/bash
sudo pacman -S base-devel
cd /var/cache/pacman/pkg 
sudo mkdir /var/cache/pacman/pkg/yay
sudo git clone https://aur.archlinux.org/yay.git
user=`whoami`
sudo chown -R $user:users /var/cache/pacman/pkg/yay
cd /var/cache/pacman/pkg/yay
makepkg -si
yay -Syy pamac-aur-git
sudo pacman -S gnome 
sudo systemctl enable gdm.service
sudo reboot
