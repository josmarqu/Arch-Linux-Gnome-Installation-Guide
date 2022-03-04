# ArchLinux-config-and-post-install-
text guide configuration and some scripts to automate the process of config ArchLinux to my requirements.

## ArchLinux-DownloadPage
https://archlinux.org/download/

## Features
 -Release: `2022.03.01`

 -Bios: `Uefi`
 
 -File System: `Btrfs`
 
 -System Backups: `Btrfs snaphsots`
 
 -Terminal:
 
 -Package Manager: `pacman, pamac, aur`
 
 -Power Saving utility: `tlp`
 
 -Display Server Protocol:` Wayland`
 
 -GUI: `Gnome`
 
 -GUI: `Qtile`
 
 -Text Editor: `VIM`
 
 -IDE: `Visual Studio, Eclipse`
 
 -Virtualization tool: `Kvm, Qemu, Virt-Manager`
 
 -Virtual Machines: `Windows 10 ltsc, Mac Os Monterey`
 
 -Browser: Microsoft `Edge, Chromium`
 
 -Email Client: `Thunderbird`
 
 -Music Service: `Spotify`
 
 -Chat Service:` Whatsapp, Discord`
 
 -Office Suite: `Microsoft Office(Virt-Manager), LibreOffice`
 
 -Image Editor: `Gimp`
 
 -Bootable Utility: `Ventoy, Balena Etcher`
 
 -Games: `Lutris, RetroArch, Super Tux Kart ;)`
 
 ## Archlinux install
    1.Boot ArchLinux ISO on your system
        Once in ArchLinux Grub select ArchLinux install.

    2.Check if Uefy mode enabled
        `ls /sys/firmware/efi/efivars`
    
    3.Internet Connection
        If you use Ethernet rj45 connection you dont need any configuration
        To setup a wireless network you need use `iwctl`
        iwtcl step by step to connect to a WPA 
            1. $ `iwctl` to get a interactive prompt
            2. $ `device list` to know your wireless device name, on the next commands where it says *device* replace with your device name
            3. $ `station *device* scan` scan for networks
            4. $ `station *device* get-networks` list available networks
            5. $ `station *device* connect *SSID*` Connect to a specific SSID, on SSID write the network you want to connect.
            6. $ Finally write $ `exit` to back to root user and write $`ping 8.8.8.8` to test your connection.
     
