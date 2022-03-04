# ArchLinux-config-and-post-install
text guide configuration and some scripts to automate the process of config ArchLinux to my requirements

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
        Once in ArchLinux Grub select ArchLinux install

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
            5. $ `station *device* connect *SSID*` Connect to a specific SSID, on SSID write the network you want to connect
            6.    Finally write $ `exit` to back to root user and write $`ping 8.8.8.8` to test your connection
     
      4. Btrfs FileSystem config
        Before to start with the partitioning we must make sure that the device only have one partition
        to manage partitions we use `fdisk`
            1.$ `fdisk -l` use this command to look at your file strutcture and find the name of the partition where you want to insall Archlinux on
            2.$ `fdisk /dev/*sda*` once we know the partiton name, write this command to enter into fdisk Command propmt
            3.  F Command to list free unpartitioned space 
            4.  If you drive have more than one partition, delete them using d Command
            5.  Once you have only one partition create the GPT partition table using g Command
            
        After perfoming the checks, we move on to partition the disk.
        Needed partitions to install ArchLinux
            - /boot/efi partition (300MB size)
            - /root partition
            - /swap (optional)

        Partitioning using fdisk step by step
            6. Repeat *1 and 2* if you exit of fdisk prompt
            7. Use n Command to create the next partitions
                - Partition 1 (/boot)
                    . Partition number= 1
                    . First sector= default
                    . Last sector= +300MB
                
                - Partition 2 (/swap)
                    . Partition number= 2
                    . First sector= default
                    . Last sector= +16GB `To calculate your swap space do (RAM GB * 2)`
                
                - Partition 3 (/root)
                    . Partition number= 3
                    . First sector= default
                    . Last sector= remaining space
