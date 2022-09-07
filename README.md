# Arch-Linux-config-and-post-install
Arch Linux installation text guide

## Arch Linux DownloadPage
https://archlinux.org/download/


## Arch Linux install
### 1.Boot Arch Linux ISO 

- Once in Arch Linux Grub select Arch Linux install

### 2.Check if Uefy mode enabled

- `ls /sys/firmware/efi/efivars`
- If the directory is empty mean that your system is running in legacy mode, instead if have files mean that your system is in Uefy mode.

### 3.Internet Connection

- If you use Ethernet rj45 connection you dont need any configuration

- To setup a wireless network you need use **iwctl**

- iwtcl step by step to connect to a WPA
```
  - 1. $ iwctl -> get a interactive prompt

  - 2. $ device list -> know your wireless device name

  - 3. $ station *device* scan -> scan for networks

  - 4. $ station *device* get-networks -> list available networks

  - 5. $ station *device* connect *SSID* -> connect to a specific SSID, on SSID write the network you want to connect

  - 6. $ exit -> back to root user and write $`ping 8.8.8.8` test your connection
  
  - 7. $ ping 8.8.8.8 -> test the connection
```
### 4.FileSystem config

- Before to start with the partitioning we must make sure that the device  have no one partition, if not you can use fdisk utility to format disk

- To manage partitions we use **fdisk**
```
  - 1.$ fdisk -l -> look at your file strutcture and find the name of the partition where you want to install Arch Linux on

  - 2.$ fdisk /dev/*sda* -> enter into fdisk command prompt

  - 3.$ F -> list free unpartitioned space

  - 4.$ d -> delete specific partition

  - 5.$ g -> create the GPT partition table 
```
- After perfoming the checks, we move on to partition the disk

- Needed partitions to install Arch Linux
```
  - /boot/efi partition (300MB size)

  - /root partition

  - /swap (optional)
```
- Partitioning using **fdisk** step by step
```
  - 6. Repeat *1 and 2* if you exit of fdisk prompt

  - 7.$ n ->  create  partition
  
  - 8. Create the next partitions

    - Partition 1 (/boot)

      - Partition number= 1

      - First sector= default

      - Last sector= +300M

    - Partition 2 (/swap)

      - Partition number= 2

      - First sector= default

      - Last sector= +16GB `To calculate your swap space do (RAM GB * 2)`

    - Partition 3 (/root)

      - Partition number= 3

      - First sector= default

      - Last sector= remaining space
   
  - 9.$ w -> write the changes
```
- Change filetype partitions
```
  - 9. Repeat *1 and 2* if you exit of fdisk prompt
  
  - 10.$ t -> change filetype partitions
  
  - 11 -> change filetype partitions as given below
  
    - Partition 1 (/boot)
    
      - Partition number= 1
      
      - Partition type or alias= 1
      
    - Partition 2 (/swap)
    
      - Partition number= 2
      
      - Partition type or alias= 1

   - 12.$ w -> write the changes
```
- Format partitions with the respective file systems.
```
  - 12.$ mkfs.fat -F32 /dev/*sda1* -> make fat32 file system, replace *sda1* with your device name used for (/boot) 
  - 13.$ mkswap /dev/sda2 ; swapon /dev/*sda2* -> make swap file system, replace *sda2* with your device name used for (/swap)
  - 14.$ mkfs.ext4 /dev/*sda3* -> make ext4 file system, replace *sda3* with your device name used for (/(root))
  - 15.$ mount /dev/sda3 /mnt -> mount the root volume to /mnt
  - 16.$ mount --mkdir /dev/*sda1* /mnt/boot -> mount boot partition
  - 17.$ lsblk -> verify that you have mounted everything correctly  
```
### 5.Installing the base system

`$ pacstrap /mnt base linux linux-firmware`

### 6.Generate fstab

- **fstab** is used to define how disk partitions should be mounted into the filesystem
```
  - 1.$ genfstab -U /mnt >> /mnt/etc/fstab -> write this to generate the fstab

  - 2.$ cat /mnt/etc/fstab -> verify fstab entries
```
### 7.Chroot into install

`$ arch-chroot /mnt -> enter in Arch Linux install to set it up`

### 8.Setting timezone

`$ ln -sf /usr/share/zoneinfo/*Europe*/*Madrid* /etc/localtime -> set timezone` 

### 9.Network configuration
```
  - 1.$ echo *JosePc* >> /etc/hostname -> replace your hostname
  
  - 2.$ pacman -Syu nano -> install nano text editor
  
  - 2.$ nano /etc/hosts -> edit host configuration adding the following lines

    - 127.0.0.1     localhost

    - ::1           localhost

  - 3. Save the file and exit 
```
### 10.Setting password for root user

`$ passwd`

### 11.Installing GRUB
```
  - 1.$ pacman -S grub -> download grub
  
  - 3.$ pacman -S efibootmgr -> install efi boot manager
 
  - 4.$ grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id = Arch -> install grub

  - 5.$ grub-mkconfig -o /boot/grub/grub.cfg ->  generate grub config file
```
### 12.Creating user with su privileges
```
  - 1.$ useradd -mg wheel *jose* -> adding user
  
  - 2.$ passwd jose -> giving  a password for a specific user

  - 3.$ pacman -S sudo -> install sudo 
  
  - 4.$ nano /etc/sudoers -> uncomment the line which says %wheel ALL=(ALL) ALL, then save and exit
```

### 13.Install and enable NetworkManager
```
  - 1.$ pacman -S networkmanager -> install network manager

  - 2.$ systemctl enable NetworkManager -> enable network manager at system boot
  
  - 3.$ pacman -S dhcpcd iwd -> only for wireless network
  
  - 4.$ systemctl enable iwd -> only for wireless network
  
```

### 14.Restarting into Arch
```
  - 1.$ `exit` exiting the installation
  
  - 2.$ `umount -l /mnt` unmounting all drives
  
  - 3.$ `reboot` to reboot the system, when the system wake enter into bios and you can boot arch booting your drive
  
  - 4.$ Search grub.efi into Efi directory and select to default boot system in Bios settings 
```

## ArchLinux Post Install



### 1. Wifi setup (only if you have wireless card)

- Once booted archlinux is time to make the post install
```
  - 1.$ dhcpcd -> active wireless dhcpcd
  
  - 2.$ dhcpcd *wlan0* -> replace *wlan0* with your wireless card devince name, to find out wich one is use ip link
  
  - 3.$ iwctl -> connect to wpa, if you dont remember how iwctl works go back to 3th step
  
  - 4.$ sudo nano /etc/iwd/main.conf -> write the bellow text to make the dhcp config
     [General]
     EnableNetworkConfiguration=true

     [Network]
     NameResolvingService=systemd
```

### 2. Nvidia drivers setup (only if you have nvidia graphic)
```
  - 1.$ pacman -Syu nvidia -> install nvidia drivers
  
  - 2.$ pacman -Syu nvidia-settings ->  install nvidia driver configuration tool
  
  - 3.$ reboot -> reboot the system 
```
### 3. Installing yay, Pamac and Gnome 
```
  - 1.$ sudo pacman -S  base-devel -> install essential packages
  
  - 2.$ cd /var/cache/pacman/pkg ->  direct  where the pacman packages are stored 
  
  - 3.$ sudo mkdir /var/cache/pacman/pkg/yay -> create a folder where yay will be stored  
  
  - 4.$ sudo pacman -Syu git -> install git
  
  - 5.$ sudo git clone https://aur.archlinux.org/yay.git -> clone yay data to later install it
  
  - 6.$ sudo chown -R *jose*:users /var/cache/pacman/pkg/yay -> give yay folder permissions for install the package
  
  - 7.$ cd yay -> direct to yay folder
  
  - 8.$ makepkg -si -> build the package and proceed with the installation
  
  - 9.$ yay -Syy pamac-aur-git -> install pamac
  
  - 10.$ sudo pacman -S gnome -> install gnome
  
  - 11.$ sudo systemctl enable gdm.service -> enable gnome at startup
  
  - 12.$ sudo reboot -> reboot the system
```

### 4. Fix Gnome Terminal
```
  - 1. control + alt + F3, enter into tty3 
 
  - 2.$ sudo locale-gen --purge  
  
  - 3.$ sudo locale-gen
  
  - 4.$ localectl set-locale LANG="en_US.UTF-8"
  
  - 5.$ sudo fc-cache -f -v
  
  - 6.$ reboot -> reboot the system
 
```
### 5. Adding Windows boot to group (only if you have windows installed)
```  
  - 1.$ sudo nano /usr/sbin/update-grub ->  create update-grub script
  
  - 2. write bellow lines
    - #!/bin/sh
    - set -e
    - exec grub-mkconfig -o /boot/grub/grub.cfg "$@"
  
  - 2.$ sudo chown root:root /usr/sbin/update-grub -> changing file ownership
  
  - 3.$ sudo chmod 755 /usr/sbin/update-grub -> changing file permissions
  
  - 4.$ sudo pacman -S os-prober ->  utility that is used to find installed os in your system
  
  - 5.$ sudo nano /etc/default/grub -> uncomment GRUB_DISABLE_OS_PROBER=false and modify timeout from 5 to 30
  
  - 6.$ sudo update-grub ->  run update-grub script
```

### 6. Adding more languages and keybord layouts
```
  - 1.$ sudo nano /etc/locale.gen -> once into the file, uncomment the language which you want to install
  
  - 2.$ locale-gen  -> generate the locales, once you did it you can enable the language added in gnome settings
```

## ArchLinux Update

- sudo pacman -Syu -> this will update the pacman repositories for package updates 
