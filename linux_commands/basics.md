# Linux Basics: File Management & Inspection

### Echo
**`echo -e`** Allows the use of special characters (like `\n` for a new line).

---

### File Management
* **`rm`**: Remove files.
* **`rm -rf`**: Remove recursively and forcefully (includes subfolders).
* **`mv`**: Move or rename a file/folder.
* **`cp`**: Copy a file/folder.
* **`touch`**: Update a timestamp or create a new file if it doesn't exist.

---

### Reading Files
* **`cat <filename>`**: Displays the entire content of a file.
* **`less <filename>`**: Opens a file for interactive reading.
    * `p50`: Jump to 50% of the text.
    * `=`: Show current location/line info.
    * `-N`: Show row numbers.
    * `/<text>`: Search forward for text.
    * `?<text>`: Search backward for text.
    * `&pattern`: Display only lines matching the pattern.
    * `n`: Find next match.

---

### WC (Word Count)
Used to count lines, words, and bytes. Default behavior is `wc -lwc`.

| Command | Description |
| :--- | :--- |
| **`wc -l`** | Count number of lines |
| **`wc -w`** | Count number of words |
| **`wc -c`** | Count number of bytes |

---

### DU (Disk Usage)
Shows the size of files and folders.
* **`du -s`**: Summary (shows only the total for the directory).
* **`du -h`**: Human-readable format (shows sizes in KB, MB, GB).
