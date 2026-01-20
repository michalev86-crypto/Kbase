# Connect Antigravity to RPI
#Antigravity Pi-Bridge Guide (WSL Edition)
#About the Project
#This project provides a workaround for developers using the Antigravity IDE on Raspberry Pi hardware.
#Because many Raspberry Pi CPUs (ARM) lack the hardware encryption (AES/AVX) required by modern AI agents, the agent crashes during initialization.
#By using Windows Subsystem for Linux (WSL) as a "Bridge," this setup allows the AI's "brain" to run on your powerful Windows CPU while the "hands" (file edits and terminal commands) operate directly on the Raspberry Pi via an SSHFS mount.

Prerequisites
Before starting, ensure you have:

Windows 11 with Administrative privileges.

Raspberry Pi (running Raspberry Pi OS/Ubuntu) on the same local network or vpn running.

Antigravity IDE installed on Windows.

OpenSSH installed on both machines.

## 1. Install WSL on Windows

1. Right-click the **Start button** and select **Terminal (Admin)** or **PowerShell (Admin)**.
2. Type the following command and press Enter:

   ```powershell
   wsl --install
   ```

3. **Restart your computer** when prompted.
4. After the restart, a Ubuntu window will open automatically. It will ask you to create a **Username** and **Password**. (Keep these handy, as you'll need the password for `sudo` commands).

## 2. On WSL

1. **Create SSH key**:

   ```bash
   ssh-keygen -t ed25519 -C "WSL-machine"
   ssh-copy-id user@RPI_IP
   ```

2. **Install SSHFS**:

   ```bash
   sudo apt update
   sudo apt install sshfs -y
   ```

2. Create directory:

   ```bash
   mkdir -p ~/pi_bridge
   ```

3. Edit fuse config:
   
   ```bash
   sudo nano /etc/fuse.conf
   # remove the # in front of user_allow_other
   ```

4. Mount the drive:

   ```bash
   sshfs user@RPI_IP:/ ~/pi_bridge -o allow_other,default_permissions,IdentityFile=~/.ssh/id_ed25519
   ```

## 4. Open Antigravity on Windows

Connect to the WSL machine with **Ctrl+Shift+P** and type: `Remote-WSL: Connect to WSL`.

1. Navigate to `/home/[your_wsl_user]/pi_bridge`.
2. SSH to the RPI with:

   ```bash
   ssh user@RPI_IP
   ```

3. Get root privileges with:

   ```bash
   sudo su -  # only if needed
   ```

## 5. Test if the agent is working

1. List all **docker containers** active now.
2. List all files in the **raid partition**.

## 6. Configure WSL to mount SSHFS automatically on boot

Run the following command:

```bash
cat << 'EOF' >> ~/.bashrc
# Auto-mount pi_bridge if not already mounted
if ! mountpoint -q ~/pi_bridge; then
    # Try to mount with a 5-second timeout to avoid unexpected hangs
    sshfs -o IdentityFile=~/.ssh/id_ed25519,reconnect,ServerAliveInterval=15,ConnectTimeout=5 micha@192.168.1.20:/home/micha ~/pi_bridge 2>/dev/null
    
    # Optional: Print a message if successful
    if [ $? -eq 0 ]; then
        echo "Connected to Pi: ~/pi_bridge"
    fi
fi
EOF
```
