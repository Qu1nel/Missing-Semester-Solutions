1. `mkdir -p /tmp/missing/`

2. `touch` - change file timstamps.

touch \[OPTIONS]... FILE...

A FILE argument that does not exist is created emtpy, unless `-c` or `-h` is supplied.

A FILE argument string of - is handled specially and causes touch to change the times of the
file associated with standart output.

3. `touch /tmp/missing/semester`

4. ```
   echo "#\!/bin/sh" >> /tmp/missing/semester
   echo "curl --head --silent https://missing.csail.mit.edu" >> /tmp/missing/semester
   ```

The symbol ! is a "history extension" and is needed in the escaping to disable\* its effect.

5. Since the file is not executable (i.e., it does not have the run permission attribute), it cannot be run by specifying its name.

6. When you specify the sh interpreter and specify a file name as an argument, the entire contents of that file are interpreted as code for sh. Thus it is executed.

7. `chmod` - change file mode bits

chmod \[OPTION]... MODE\[,MODE]... FILE...

A chmod command changes the file mode bits of each given file according to mode (permission), wich can be either a symbolic representation of changes to make, or
an octal number representation the bit pattern for the new mode bits.

`-v, --verbose` - output diagnostic for every file processed
`-c, --changes` - like verbose but report only when a change is made

MODES:

- r - read permission (4) - 0b100 - 0o4
- w - write permission (2) - 0b010 - 0o2
- x - exectute permission (1) - 0b001 - 0o1

rw - 0b110 - 0o6
rx - 0b101 - 0o5

8. `chmode +x /tmp/missing/semester`

Shebang - is the sequence characters and "#!" in the begging of a script.
When an executable with a shebang is loaded for execution, the interpreter's loading mechanism (which can be thought of as a program built into the shell)
identifies the path specified in the shebang and passes the executable as an argument to that path.
Only in UNIX.

9. `/tmp/missing/semester | grep -i last-mod > "last-modified.txt`

10. `cat /sys/class/hwmon/hwmon0/temp*_input | sed 's \(.\)..$ .\1°C '`
