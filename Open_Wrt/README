all files are as is on the machine.
installation guide:
for RPI 4 - 
download openwrt-bcm2711-rpi-4-ext4-sysupgrade.img
steps of installation:

1. download and image wrt to the sd
2. on linux device, resize the sd card to one parttion:
	lsblk (assume it is now sdb1 and sdb2)
	unmunt the device:
	sudo umount /medi/(username)/rootfs
	sudo umount /medi/(username)/bootfs

3.fdiisk:
	sudo fdisk /dev/sdb
	p -> d -> 2
	n -> p -> 2
	147456 (start sector of the second parttion - find it on the table under start of /dev/sdb2)
	enter (last sector)
	n
	w

4.cleanup and resize:
	sudo e2fsck -f /dev/sdb2 (y)
	sudo resize2fs /dev/sdb2
	sudo unmount /dev/sdb1

5.moove the sd to the RPI
6.connect the RPI to the PC and disconnect any other network addapters
7.on the pc (win) ipconfig - shuld have ip and gateway of 192.168.1.1
8.ssh to  192.168.1.1 u: root , no password

9.change password:
	passwd

10.then change network:
		config interface 'lan'
        option device 'bridge'
		ifname 'eth0'
        option proto 'static'
        option ipaddr '192.168.1.2'
        option netmask '255.255.255.0'
        option gateway '192.168.1.1'
        list dns '8.8.8.8'
	:wq
	
11. restart network: service network restart or: /etc/init.d/network restart
12.connect the rpi to the router of the home network
13.ssh to 192.168.1.2 root no passwd needed
14.ping google.com
15. change password: passwd
16.packges and installitions
	16.1: opkg update
	16.2 opkg install htop nano tmux iftop
	16.3 opkg install luci-ssl-nginx
	# Now enable and start the nginx
	service nginx enable
	service nginx start
17. install drivers:
17. plug the addapter to windows machine, go to control panel , device maneger, network adapters, click on the adapter -> properties -> go to details tab
	int the "property dropdown and select hardware ids - > this is the chipset! ( mine is obda&pid_8153)
	
17.2find your driver: opkg list kmod-usb-net*
		opkg install kmod-usb-net-rtl8152
17.3 install usbutils:
	opkg install usbutils usb-modeswitch
	vi /boot/cmdline.txt - > at the end of the line add space and: usbcore.autosuspend=-1
	17.3.1 veryfication: lsusb -> ... lsmod | grep rtl8152
18.Connect your USB2Eth adapter and check network interfaces list with help of command: ip a, and confirm that your device is there, if not, reboot it. In my case it showed up just fine, with eth1 as it’s name.
19. check network interfaces
	ip a 
	or: ip addr show
option (check if needed)
	login to luci
	software -> update lists
	find usb-net-asix-ax88179 install
20 plug internet cable to the usb adapter and to the RPI
21.Nevigate to Networks and add interface
ON PI: change the eth0 to eth1 on nwtwork, change the cable to the usb addapter and restart network
21.1 NAME: WAN
	protocol ppoe
	device: eth0
	firewall wan
	
	final working configuration:
		files are in the folders

