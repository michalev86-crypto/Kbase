# Networking
### IP & Interface
* `ip addr show`: View IPs.
* `ip link set <dev> up/down`: Enable/Disable interface.
* `ip addr add <ip>/<prefix> dev <dev>`: Set IP.

### Routing
* `ip route show`: View routing table.
* `ip route add <net> via <gw> dev <dev>`: Add route.

### Logs & Scanning
* `journalctl -u NetworkManager`: DHCP/Network logs.
* `nmap <target>`: Scan top 1000 ports.
* `nmap -p <port> <target>`: Scan specific port.
