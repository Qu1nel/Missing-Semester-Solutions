# Solutions of Lectures 2

1. Read `man ls` and write an `ls` command that lists files in the following manner

   - Includes all files, including hidden files
   - Sizes are listed in human readable format (e.g. 454M instead of 454279954)
   - Files are ordered by recency
   - Output is colorized

   **Solution:** run the following commands in your terminal:

   ```bash
   ls --color=always -laht
   ```

2. Write bash functions `marco` and `polo` that do the following. Whenever you execute
   `marco` the current working directory should be saved in some manner, then when
   you execute `polo`, no matter what directory you are in, `polo` should `cd` you back
   to the directory where you executed `marco`. For ease of debugging you can write
   the code in a file `marco.sh` and (re)load the definitions to your shell by
   executing source `marco.sh`

   **Solution:**

   ```bash
    #!/usr/bin/env bash
    # in marco.sh

    marco ()
    {
        MarcoPoloPath="$(pwd)"
    }

    polo ()
    {
        [[ -n "$MarcoPoloPath" ]] && cd "$MarcoPoloPath" || return 1
    }
   ```

3. Say you have a command that fails rarely. In order to debug it you need to
   capture its output but it can be time consuming to get a failure run. Write a
   bash script that runs the following script until it fails and captures its
   standard output and error streams to files and prints everything at the end.
   Bonus points if you can also report how many runs it took for the script to fail.

   **Solution:**

   ```bash
   #!/usr/bin/env bash
   # in debug_script.sh

   if [[ "$#" -ne 1 || ! -x "$1" ]]; then
       echo "You must pass the test file as a single argument" 1>&2
       exit 1
   fi

   result_log_file="log_debugging.log"

   count_attempts=1
   until [[ "$?" -ne 0 ]]; do
       count_attempts="$((count_attempts + 1))"
       ./"$1" &> "${result_log_file}"
   done

   echo "Number of successful attempts before failure: ${count_attempts}"
   echo "Result output of $1 in ${result_log_file}"
   ```

4. As we covered in the lecture `find`’s `-exec` can be very powerful for performing
   operations over the files we are searching for. However, what if we want to
   do something with all the files, like creating a zip file? As you have seen
   so far commands will take input from both arguments and STDIN. When piping
   commands, we are connecting STDOUT to STDIN, but some commands like `tar` take
   inputs from arguments. To bridge this disconnect there’s the [`xargs`](https://www.man7.org/linux/man-pages/man1/xargs.1.html)
   command which will execute a command using STDIN as arguments. For example
   `ls | xargs rm` will delete the files in the current directory.

   Your task is to write a command that recursively finds all HTML files in the
   folder and makes a zip with them. Note that your command should work even if
   the files have spaces (hint: check `-d` flag for `xargs`).

   **Solution:** run the commands in your terminal.

   ```bash
   find . -type f -iname "*.html" -print0 | xargs -0 tar -acf result.tar
   fd . -t file -e html -0 | xargs -0 tar -acf result.tar
   ```

5. (Advanced) Write a command or script to recursively find the most recently
   modified file in a directory. More generally, can you list all files by recency?

   **Solution:**

   ```python
   #!/usr/bin/env python3
   import os
   from datetime import datetime as dt
   from os.path import getctime
   from os.path import join as join_path


   def main() -> None:
       for folder in os.walk("."):
           path = folder[0]
           files = folder[2]

           oldest_file_time = dt.now()
           oldest_file_name = None

           for file in files:
               file_path = join_path(path, file)
               time_file = dt.fromtimestamp(getctime(file_path))

               if oldest_file_time > time_file:
                   oldest_file_time = time_file
                   oldest_file_name = file

           if oldest_file_name:
               path = path.lstrip(r".\/")
               print(f"Path {path:50}: {oldest_file_time} - {oldest_file_name:^50}")


   if __name__ == "__main__":
       main()
   ```
