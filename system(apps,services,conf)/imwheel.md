# IMWHEEL

## IMWheel is a tool for tweaking mouse wheel behavior

## I use it to increase the scroll speed on the mouse

### Install imwheel tool
- $`pacman -S imwheel`

### Config imwheel to tweak the mouse wheel behavior

-1. $`nano .imwheelrc` 

-2. Add the lines bellow
```
  ".*"
    None, Up, Button4, 4
    None, Down, Button5, 4
```
  - This will set the scroll sensitivity to 4 for all programs
  
### Creating imwheel service for boot startup

-1. $`mkdir ~/.config/systemd`

-2. $`mkdir ~/.config/systemd/user`

-3. $`nano imwheel.service`

-4. Add the lines bellow
```                              
[Unit]
Description=IMWheel
Wants=display-manager.service
After=display-manager.service

[Service]
Type=simple
Environment=XAUTHORITY=%h/.Xauthority
ExecStart=/usr/bin/imwheel -b 45
ExecStop=/usr/bin/pkill imwheel
RemainAfterExit=yes

[Install]
WantedBy=graphical-session.target
```
-5. $`systemctl --user deamon-reload`

-6. $`systemctl --user enable --now imhweel`

-7. $`journalctl --user --unit imwheel`


