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
systemctl enable virtnetworkd
systemctl start virtnetworkd
pamac install chromium
pamac install microsoft-edge-stable-bin
pamac install thunderbird
pamac install spotify
pamac install discord
pamac install libreoffice
pamac install gimp
pamac install ventoy-bin
pamac install lutris
pamac install retroarch
pamac install cpupower-gui
pamac install gnome-tweaks
numbline1=(grep -n -F "#[multilib]" /etc/pacman.conf | cut -f1 -d:)
numbline2=$((numbline1+2))
sed -i   "$numbline1 s/#/ /" /etc/pacman.conf
sed -i   "$numbline2 s/#/ /" /etc/pacman.conf
sed -i .stop.
pacman -Sy
pacman -S steam
