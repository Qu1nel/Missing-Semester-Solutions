# Solutions of Lectures 1

1. Create a new directory called `missing` under `/tmp`.

   **Solution:** run the following commands in your terminal.

   ```bash
   mkdir -p /tmp/missing/
   ```

3. Look up the `touch` program. The `man` program is your friend.

   **Solution:** we can use `tldr touch` or `man touch`
   ```
   `touch` - change file timstamps.

   touch \[OPTIONS]... FILE...

   A FILE argument that does not exist is created emtpy, unless `-c` or `-h` is supplied.

   A FILE argument string of - is handled specially and causes touch to change the times of the
   file associated with standart output.
   ```

4. Use `touch` to create a new file called `semester` in `missing`.

   **Solution:** run the following commands in your terminal.
   
   ```bash
   touch /tmp/missing/semester
   ```

5. Write the following into that file, one line at a time:

   **Solution:** run the following commands in your terminal.

   ```bash
   echo "#\!/bin/sh" >> /tmp/missing/semester
   echo "curl --head --silent https://missing.csail.mit.edu" >> /tmp/missing/semester
   ```

   The symbol ! is a "history extension" and is needed in the escaping to disable\* its effect.

6. Try to execute the file, i.e. type the path to the script (`./semester`) into your shell and
   press enter. Understand why it doesn’t work by consulting the output of `ls` (hint: look at
   the permission bits of the file)
   
   **Solution:**
   
   Since the file is not executable (i.e., it does not have the run permission attribute), it
   cannot be run by specifying its name.

7. Run the command by explicitly starting the `sh` interpreter, and giving it the file `semester`
   as the first argument, i.e. `sh semester`. Why does this work, while `./semester` didn't?

   **Solution:**

   When you specify the sh interpreter and specify a file name as an argument, the entire contents
   of that file are interpreted as code for sh. Thus it is executed.

8. Look up the `chmod` program (e.g. use `man chmod`).

   **Solution:**
   
   `chmod` - change file mode bits
   
   chmod \[OPTION]... MODE\[,MODE]... FILE...
   
   A chmod command changes the file mode bits of each given file according to mode (permission), wich
   can be either a symbolic representation of changes to make, or an octal number representation the
   bit pattern for the new mode bits.
   
   `-v, --verbose` - output diagnostic for every file processed
   
   `-c, --changes` - like verbose but report only when a change is made
   
   MODES:
   
   - r - read permission (4) - 0b100 - 0o4
   - w - write permission (2) - 0b010 - 0o2
   - x - exectute permission (1) - 0b001 - 0o1
     
   rw - 0b110 - 0o6
   
   rx - 0b101 - 0o5

9. Use `chmod` to make it possible to run the command `./semester` rather than having to type `sh semester`.
   How does your shell know that the file is supposed to be interpreted using `sh`? See this page on the
   [shebang](https://en.wikipedia.org/wiki/Shebang_(Unix)) line for more information.

   **Solution:** run the following commands in your terminal.
   
   ```bash
   chmode +x /tmp/missing/semester
   ```

   Shebang - is the sequence characters and "#!" in the begging of a script. When an executable with a
   shebang is loaded for execution, the interpreter's loading mechanism (which can be thought of as a
   program built into the shell) identifies the path specified in the shebang and passes the executable
   as an argument to that path. Only in UNIX.

11. Use `|` and `>` to write the “last modified” date output by `semester` into a file called `last-modified.txt`
    in your home directory.

    **Solution:**

    ```bash
    /tmp/missing/semester | grep -i last-mod > "last-modified.txt
    ```

13. Write a command that reads out your laptop battery’s power level or your desktop machine’s CPU temperature from
    `/sys`. Note: if you’re a macOS user, your OS doesn’t have sysfs, so you can skip this exercise.

    **Solution:** (for Arch) run the following commands in your terminal.

    ```bash
    cat /sys/class/hwmon/hwmon0/temp*_input | sed 's \(.\)..$ .\1°C '
    ```
