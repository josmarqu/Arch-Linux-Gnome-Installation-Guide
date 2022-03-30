# BTRFS SNAPSHOT

## PREPARE FILESYSTEM FOR SNAPSHOTS
- Needed requirements
 
  - BTRFS FILESYSTEM PARTITION
 
  - SUBVOLUME FOR SNAPSHOTS STORAGE

## REALIZE SNAPHSOT
- make snapshot
`$ sudo btrfs subvolume snapshot /example /.snapshots/example`

- view snapshot data info
`$ sudo btrfs subvolume show /.snapshots/example`

## RECOVER DATA LOST FROM THE SNAPSHOT DIRECTORY
`$ sudo rsync -avz /.snapshots/example/ /example(folder data lost)/`
