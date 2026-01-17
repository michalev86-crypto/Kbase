# Kbase
auto raid project


* [raid_wachdog_file](raid-watchdog.sh)
* [wach_dog_service](raid-watchdog.service)
* [systemd_timer](raid-watchdog.timer)
  
How to install
create files:  
    * `/usr/local/bin/raid-watchdog.sh`  
    * `/etc/systemd/system/raid-watchdog.service`  
    * `/etc/systemd/system/raid-watchdog.timer`  
    * `/var/log/raid-watchdog.log`  

2. Set permissions:  
	sudo chmod +x /usr/local/bin/raid-watchdog.sh
	sudo chmod 664 /var/log/raid-watchdog.log

3. Enable the timer:  
	sudo systemctl daemon-reload
	sudo systemctl enable --now raid-watchdog.timer

How to Test (Safe Simulation)  

To verify the watchdog works without waiting for a real hardware failure:  

1. Stop Docker manually:  
	cd /mnt/ssd240/immich-app && sudo docker compose down


2. Break the RAID:  
	sudo umount /mnt/raid1  
	sudo mdadm --stop /dev/md0


3. Run the watchdog manually:  
	sudo systemctl start raid-watchdog.service

How to Watch it in Action

A. Monitor the Timer
Check when the next check is scheduled:  
Bash
	systemctl list-timers  
	raid-watchdog.timer  

B. View Live Recovery Logs
If the RAID fails, you can watch the script perform the reset and restart services in real-time:
Bash
	journalctl -u raid-watchdog.service -f

C. Check RAID Status
Verify the array is back online after a recovery:  
Bash
	cat /proc/mdstat  
	lsblk

log files:
 View the last 20 entries:  
	tail -n 20 /var/log/raid-watchdog.log

Watch the logs live (real-time):  
	tail -f /var/log/raid-watchdog.log

