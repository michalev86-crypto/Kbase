# Permissions & Special Bits
### Levels
* **u** (Owner), **g** (Group), **o** (Others).
* **r** (4), **w** (2), **x** (1).

### Commands
* `chmod 754 file`: (rwx for u, r-x for g, r-- for o).
* `chown user:group -R <dir>`: Recursive ownership change.
* `umask`: Defines default permissions.

### Special Bits
* **Sticky Bit (`+t`)**: Only owner can delete files in folder (e.g., `/tmp`).
* **SUID (`u+s`)**: Executable runs with owner rights.
* **SGID (`g+s`)**: Executable runs with group rights.
