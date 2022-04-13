#!/bin/bash
pamac install tlp
sed -i 's/#CPU_SCALING_GOVERNOR_ON_AC=powersave/CPU_SCALING_GOVERNOR_ON_AC=performance/g' /etc/tlp.conf
sed -i 's/#CPU_SCALING_GOVERNOR_ON_BAT=powersave/CPU_SCALING_GOVERNOR_ON_BAT=powersave/g' /etc/tlp.conf
systemctl enable tlp
systemctl start tlp
pamac install vim
pamac install visual-studio-code-bin
pamac install eclipse-java
pamac install virt-manager
pamac install qemu
pacman -S net-tools
systemctl enable virtnetworkd
systemctl start virtnetworkd
pamac install dnsmasq
systemctl enable dnsmasq
systemctl start dnsmasq
pamac install chromium
pamac install microsoft-edge-stable-bin
pamac install thunderbird
pamac install spotify
pamac install discord
pamac install libreoffice
pamac install gimp
pamac install etcher-bin
pamac install ventoy-bin
pamac install cpupower-gui
pamac install gnome-tweaks
pacman -Sy
pacman -S steam
pamac install qtile python-dbus-next python-pywlroots
pacman -S alsa-utils
amixer sset Master unmute
pamac install gdm-settings-git
pamac install marker
