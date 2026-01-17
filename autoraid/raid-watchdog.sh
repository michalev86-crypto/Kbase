#!/bin/bash

# Configuration
RAID_DEVICE="/dev/md0"
USB_ID="2-1"
IMMICH_DIR="/mnt/ssd240/immich-app"
SERVICES=("smbd" "docker") # Samba and Docker engine

# Check if RAID is active
if ! grep -q "active" /proc/mdstat; then
    echo "$(date): RAID array is DOWN. Starting full recovery sequence..."

    # 1. Stop services to prevent data corruption during reset
    echo "Stopping services..."
    for service in "${SERVICES[@]}"; do
        systemctl stop "$service"
    done

    # 2. Reset the USB Port (Unbind/Bind)
    if [ -e "/sys/bus/usb/drivers/usb-storage/$USB_ID" ]; then
        echo "Resetting USB Port $USB_ID..."
        echo "$USB_ID" > /sys/bus/usb/drivers/usb-storage/unbind
        sleep 3
        echo "$USB_ID" > /sys/bus/usb/drivers/usb-storage/bind
        sleep 5
    else
        echo "Error: USB ID $USB_ID not found in usb-storage driver."
    fi

    # 3. Force re-scan of the RAID and mount
    echo "Assembling RAID and mounting..."
    mdadm --assemble --scan
    sleep 2
    mount -a

    # 4. Restart System Services (Samba and Docker Engine)
    echo "Starting system services..."
    for service in "${SERVICES[@]}"; do
        systemctl start "$service"
    done

    # 5. Explicitly restart Immich stack
    echo "Restarting Immich containers..."
    if [ -d "$IMMICH_DIR" ]; then
        cd "$IMMICH_DIR" && /usr/bin/docker compose up -d
    else
        echo "Error: Immich directory $IMMICH_DIR not found."
    fi

    echo "$(date): Recovery attempt finished."
else
    # RAID is healthy
    exit 0
fi
