# User & Group Management
### Files
* `/etc/passwd`: User info.
* `/etc/shadow`: Encrypted passwords.
* `/etc/group`: Group info.

### Commands
* `useradd -m -s /bin/bash <user>`: Add user with home and shell.
* `passwd <user>`: Change password.
* `usermod -aG <group> <user>`: Add user to a secondary group.
* `userdel -r <user>`: Delete user and home folder.
* `groups <user>`: List user groups.

### Common Groups
* `sudo`/`wheel`: Sudo rights.
* `adm`: Access logs.
* `www-data`: Web server.
