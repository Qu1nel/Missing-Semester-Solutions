# Solutions of Lecture 5

1. ### Job control

   1. From what we have seen, we can use some `ps aux | grep commands` to get our jobs’
      pids and then kill them, but there are better ways to do it. Start a `sleep 10000`
      job in a terminal, background it with `Ctrl-Z` and continue its execution
      with `bg`. Now use `pgrep` to find its pid and `pkill` to kill it without ever typing
      the pid itself. (Hint: use the `-af` flags).

   ##### **Solution:** run the following commands in your terminal

   ```bash
   for i in "$(seq 10)"; do sleep 10000 &; done
   pgrep "sleep" | xargs kill -9
   # OR
   pkill -f "sleep"
   ```

   2. Say you don't want to start a process until another completes, how you would go
      about it? In this exercise our limiting process will always be `sleep 60 &`.
      One way to achieve this is to use the [`wait`](https://www.man7.org/linux/man-pages/man1/wait.1p.html)
      command. Try launching the sleep command and having an `ls` wait until the background
      process finishes.

      However, this strategy will fail if we start in a different bash session, since
      `wait` only works for child processes. One feature we did not discuss in the
      notes is that the `kill` command's exit status will be zero on success and
      nonzero otherwise. `kill -0` does not send a signal but will give a nonzero
      exit status if the process does not exist. Write a bash function called `pidwait`
      that takes a pid and waits until the given process completes. You should use
      `sleep` to avoid wasting CPU unnecessarily.

   ##### **Solution:** run the following commands in your terminal

   ```bash
    #!/usr/bin/env bash

    pidwait ()
    {
        if [[ "$#" -ne 1 ]] || ! [[ "$1" =~ '^[0-9]+$' ]]; then
            echo "The pidwait function takes a single numeric argument!" 1>&2
            return 1
        fi

        until [[ "$?" -ne 0 ]]; do
            sleep 1
            kill -0 "$1" 2>/dev/null
        done
    }
   ```

2. ### Aliases

   1. Create an alias `dc` that resolves to `cd` for when you type it wrongly.

   ##### **Solution:** run the following commands in your terminal

   ```bash
   alias dc='cd'
   ```

   2. Run `history | awk '{$1="";print substr($0,2)}' | sort | uniq -c | sort -n | tail -n 10`
      to get your top 10 most used commands and consider writing shorter aliases for
      them. Note: this works for Bash; if you’re using ZSH, use `history 1` instead of just history.\

   ##### **Solution:** run the following command in your terminal

   ```bash
   alias topcmd="history 1 | awk '{\$1=\$2=\$3=\"\";print \$0}' | sed 's/   //' | sort | uniq -c | sort -n | uniq | tail -20"
   ```
