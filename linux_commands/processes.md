# Processes & Signals
### Listing Processes
* `ps -ef`: Full list of processes.
* `ps aux`: User-oriented process list.
* `pgrep <name>`: Get PID by name.

### Priorities (Niceness)
* **Range:** -20 (High) to 19 (Low).
* `nice -n <val> <cmd>`: Start with priority.
* `renice -n <val> -p <PID>`: Change priority of running process.

### Signals
* `kill -l`: List all signals.
* `SIGINT (2)`: Ctrl+C.
* `SIGTERM (15)`: Graceful stop.
* `SIGKILL (9)`: Force kill.
* `SIGSTOP`/`SIGCONT`: Pause/Resume.
