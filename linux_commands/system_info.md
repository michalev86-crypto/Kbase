# System Info & I/O
### Buffered vs Unbuffered
* **Unbuffered:** Real-time, direct I/O (keyboard, sensors).
* **Buffered:** Accumulates data in temporary storage for efficiency (disk/network).

### Pseudo Devices
* `/dev/null`: Discards data (Black hole).
* `/dev/random`: Random numbers from noise.
* `/dev/urandom`: Faster random (reuses noise).
* `/dev/stdin`, `/dev/stdout`, `/dev/stderr`.

### System Insights
* `cat /proc/cpuinfo`: CPU cores/info.
* `cat /proc/meminfo`: RAM/memory usage.
* `cat /proc/version`: Kernel & Distro info.
* `cat /proc/uptime`: System uptime & idle time.
* `cat /proc/loadavg`: System load average.
