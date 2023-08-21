2. Find the number of words (in `/usr/share/dict/words`) that contain at least
   three `a`s and don’t have a `'s` ending. What are the three most common last
   two letters of those words? `sed`’s `y` command, or the `tr` program, may help
   you with case insensitivity. How many of those two-letter combinations
   are there? And for a challenge: which combinations do not occur?

   **Solution:** run the following commands in your terminal.

   1.

   ```bash
   cat /usr/share/dict/words | grep -v "'s$" | grep -iP '.*a.*a.*a.*' | wc -l
   ```

   2.

   ```bash
   cat /usr/share/dict/words | grep -v "'s$" | grep -iP '.*a.*a.*a.*' | sed -E 's/.*(..)/\1/' | uniq -c | sort -nk1,1 | tail -3 | awk '{print $2}'
   ```

3. To do in-place substitution it is quite tempting to do something like
   `sed s/REGEX/SUBSTITUTION/ input.txt > input.txt`. However this is a
   bad idea, why? Is this particular to `sed`? Use `man sed` to find out how to
   accomplish this.

   **Solution:**

   -Replace all `apple` (basic regex) occurrences with `mango` (basic regex) in
   specific file and overwrite the original file in place:

   ```bash
   sed -i 's/apple/magno/g' path/to/file
   ```

4. Find your average, median, and max system boot time over the last ten boots.
   Use `journalctl` on Linux and `log show` on macOS, and look for log timestamps
   near the beginning and end of each boot. On Linux, they may look something like:

   ```bash
   Logs begin at ...
   ```

   and

   ```bash
   systemd[577]: Startup finished in ...
   ```

   On macOs, [look for](https://eclecticlight.co/2018/03/21/macos-unified-log-3-finding-your-way/):

   ```bash
   === system boot:
   ```

   and

   ```bash
   Previous shutdown cause: 5
   ```

   **Solution:** (on Arch Linux)

   ```bash
   sudo journalctl | grep -iE 'startup finished in.*[0-9.]+s\.' | sed -E 's|.*= (.*)s\.|\1|g' | R --slave -e 'x <- scan(file="stdin", quiet=TRUE); summary(x)'
   ```
