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
### 1.Boot ArchLinux ISO on your system

- Once in ArchLinux Grub select ArchLinux install

### 2.Check if Uefy mode enabled

- `ls /sys/firmware/efi/efivars`

### 3.Internet Connection

- If you use Ethernet rj45 connection you dont need any configuration

- To setup a wireless network you need use `iwctl`

- iwtcl step by step to connect to a WPA
```
  - 1. $ `iwctl` to get a interactive prompt

  - 2. $ `device list` to know your wireless device name, on the next commands where it says *device* replace with your device name

  - 3. $ `station *device* scan` scan for networks

  - 4. $ `station *device* get-networks` list available networks

  - 5. $ `station *device* connect *SSID*` Connect to a specific SSID, on SSID write the network you want to connect

  - 6. Finally write $ `exit` to back to root user and write $`ping 8.8.8.8` to test your connection
```
### 4.Btrfs FileSystem config

- Before to start with the partitioning we must make sure that the device only have one partition

- To manage partitions we use `fdisk`
```
  - 1.$ `fdisk -l` use this command to look at your file strutcture and find the name of the partition where you want to insall Archlinux on

  - 2.$ `fdisk /dev/*sda*` once we know the partiton name, write this command to enter into fdisk Command propmt

  - 3. F Command to list free unpartitioned space

  - 4. If you drive have more than one partition, delete them using d Command

  - 5. Once you have only one partition create the GPT partition table using g Command
```
- After perfoming the checks, we move on to partition the disk

- Needed partitions to install ArchLinux
```
  - /boot/efi partition (300MB size)

  - /root partition

  - /swap (optional)
```
- Partitioning using fdisk step by step
```
  - 6. Repeat *1 and 2* if you exit of fdisk prompt

  - 7. Use n Command to create the next partitions

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
   
  - 8. Use w Command to write the changes
```
- Change filetype partitions
```
  - 9. Repeat *1 and 2* if you exit of fdisk prompt
  
  - 10. Use t Command to change filetype partions as given below
  
    - Partition 1 (/boot)
    
      - Partition number= 1
      
      - Partition type or alias= 1
      
    - Partition 2 (/swap)
    
      - Partition number= 2
      
      - Partition type or alias= 1

  - 11. Use w Command to write the changes  
```
- Format partitions with the respective file systems.
```
  - 12.$ `mkfs.fat -F32 /dev/*sda1*` make fat32 file system, replace *sda1* with your device name used for (/boot) 
  - 13.$ `mkswap /dev/sda2` ; swapon /dev/*sda2*` make swap file system, replace *sda2* with your device name used for (/swap)
  - 14.$ `mkfs.btrfs /dev/*sda3*` make btrfs file system, replace *sda3* with your device name used for (/(root))
```

- Btrfs Features Personal setup
```
  - 15. Create the following Subvolume scheme

    - $ `btrfs su cr /mnt/@`
  
    - $ `btrfs su cr /mnt/@home`

    - $ `btrfs su cr /mnt/@.snapshots`

  - 16.$ `umount /mnt` unmount  mnt folder

  - 17.$ `mkdir /mnt/{boot,home,.snapshots}` create the folders where subvolumes will mounted.

  - 18. Mount these partitions
  
    - $ `mount -o noatime,compress=zstd,discard=async,subvol=@ /dev/*sda3* /mnt`

    - $ `mount -o noatime,compress=zstd,discard=async,subvol=@home /dev/*sda3* /mnt/home`
     
    - $ `mount -o noatime,compress=zstd,discard=async,subvol=@.snapshots /dev/*sda3* /mnt/.snapshots`

      - Mount options used brief explanation

        - noatime : No access time, Improves system performances by not writing time when the file was accesed

        - compress=zstd : Chosing the algorithm for compress. I have zstd as it has good compression level and speed
  
        - discard= async : ONLY USE IF YOU SYSTEM PARTITION IS MOUNTED ON A SSD DEVICE, enable discarding of freed file blocks improving performance

        - subvol : Choosing the subvol to mount.

  - 19.$ `mount /dev/*sda1* /mnt/boot` mount boot partition

  - 20.$ `lsblk` verify that you have mounted everything correctly  
```
### 5.Installing the base system

- For Intel CPUs: $ `pacstrap /mnt base linux linux-firmware nano intel-ucode btrfs-progs`

- For Amd Cpus: $ `pacstrap /mnt base linux linux-firmware nano amd-ucode btrfs-progs`

- For VMs: $ `pacstrap /mnt base linux linux-firmware nano btrfs-progs`

### 6.Generate fstab

- `fstab` is used to define how disk partitions should be mounted into the filesystem
```
  - 1.$ `genfstab -U /mnt >> /mnt/etc/fstab` write this to generate the fstab

  - 2.$ `cat /mnt/etc/fstab` to verify fstab entries
```
### 7.Chroot into install

- $ `arch-chroot /mnt` to enter in your Arch install to set it up

### 8.Setting timezone

- $ `ln -sf /usr/share/zoneinfo/*Europe*/*Madrid* /etc/localtime` set your timezone 

### 9.Network configuration
```
  - 1.$ `echo *JosePc* >> /etc/hostname` to replace your hostname

  - 2.$ ` nano /etc/hosts`  edit host configuration adding the following lines

    - 127.0.0.1     localhost

    - ::1           localhost

    - 127.0.1.1     myhostname.localdomain myhostname

  - 3. Save the file and exit 
```
### 10.Setting password for root user

- $`passwd`

### 11.Adding btrfs module to mkinitcpio
```
  - 1.$ `nano /etc/mkinitcpio.conf` and add MODULES=(btrfs) bellow to #MODULES=(piix ide_disk reiserfs), then save and exit

  - 2.$ `mkinitcpio -p linux` to recreate the image
```
### 12.Installing GRUB
```
  - 1.$ `pacman -S grub grub-btrfs` to download grub
  
  - 3.$ `pacman -S efibootmgr` to install efi boot manager
 
  - 4.$ `grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id = Arch` to install grub

  - 5.$ `grub-mkconfig -o /boot/grub/grub.cfg` to generate grub config file
```
### 13.Creating user
```
  - 1.$ `useradd -mg wheel *jose*` adding user
  
  - 2.$ `passwd jose` giving  a password

  - 3.$ `pacman -S sudo` to install sudo 
  
  - 4.$ `nano /etc/sudoers` and inside uncomment the line which says %wheel ALL=(ALL) ALL, then save and exit
```

### 14.Install and enable NetworkManager
```
  - 1.$ `pacman -S networkmanager` to install network manager

  - 2.$ `systemctl enable NetworkManager` to enable network manager at system boot
```

### 15.Restarting into Arch
```
  - 1.$ `exit` exiting the installation
  - 2.$ `umount -l /mnt` unmounting all drives
  - 3.$ `reboot` to reboot the system, when the system wake enter into bios and you can boot arch booting your drive
  - 4.$ Search grub.efi into Efi directory and select to default boot system in Bios settings 
