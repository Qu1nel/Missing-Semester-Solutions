# Solutions of Lecture 7

# Debugging

1. Use `journalctl` on Linux or `log show` on macOS to get the super user accesses
   and commands in the last day. If there aren’t any you can execute some
   harmless commands such as `sudo ls` and check again.

**Solution:**

```bash
journalctl --since "1 day ago" | rg "$HOST sudo" | rg -o "COMMAND=.*" | sed -E 's COMMAND=(.+)/(.+) \2 ' | sort | uniq | sort
```

3. Install ['shellcheck`](https://www.shellcheck.net) and try checking the
   following script. What is wrong with the code? Fix it. Install a linter
   plugin in your editor so you can get your warnings automatically. Install
   shellcheck and try checking the following script. What is wrong with
   the code? Fix it.

   ```bash
    #!/bin/sh
    ## Example: a typical script with several problems
    for f in $(ls *.m3u)
    do
      grep -qi hq.*mp3 $f \
        && echo -e 'Playlist $f contains a HQ file in mp3 format'
    done
   ```

**Solution:**

```bash
#!/usr/bin/env bash
## Example: a typical script with several problems
for f in *.m3u
do
  grep -qi "hq.*mp3" "$f" \
    && echo -e "Playlist $f contains a HQ file in mp3 format"
done
```

# Profiling

5. [Here](https://missing.csail.mit.edu/static/files/sorts.py) are some sorting
   algorithm implementations. Use [`cProfile`](https://docs.python.org/3/library/profile.html)
   and [`line_profiler`](https://github.com/pyutils/line_profiler) to compare
   the runtime of insertion sort and quicksort. What is the bottleneck of each
   algorithm? Use then `memory_profiler` to check the memory consumption, why
   is insertion sort better? Check now the inplace version of quicksort.
   Challenge: Use `perf` to look at the cycle counts and
   cache hits and misses of each algorithm.

   **Solution:**

   > What is the bottleneck of each algorithm?

   - For `insert_sort` - speed of execution, for quick_sort - memory consumption.

   > Use then `memory_profiler` to check the memory consumption, why is insertion sort better?

   - quick sort uses recursion, and recursion is a function call, which in turn
     implies the use of a so-called call stack. each new call to quick_sort
     generates a stack frame, which copies all local variables, thus using more
     imemory.

6. Here’s some (arguably convoluted) Python code for computing Fibonacci
   numbers using a function for each number.

   ```python
    #!/usr/bin/env python
    def fib0(): return 0

    def fib1(): return 1

    s = """def fib{}(): return fib{}() + fib{}()"""

    if __name__ == '__main__':
        for n in range(2, 10):
            exec(s.format(n, n-1, n-2))
        # from functools import lru_cache
        # for n in range(10):
        #     exec("fib{} = lru_cache(1)(fib{})".format(n, n))
        print(eval("fib9()"))
   ```

   Put the code into a file and make it executable. Install prerequisites:
   [`pycallgraph`](https://pycallgraph.readthedocs.io/) and
   [`graphviz`](http://graphviz.org/). (If you can run `dot`, you already have GraphViz.)
   Run the code as is with `pycallgraph graphviz -- ./fib.py` and check the
   `pycallgraph.png file.`

   > How many times is fib0 called?

   - 109 times.

   We can do better than that by memoizing the functions. Uncomment the
   commented lines and regenerate the images. How many times are we calling
   each fibN function now?

   - 10 times.

7. A common issue is that a port you want to listen on is already taken by
   another process. Let’s learn how to discover that process pid. First execute
   execute `python -m http.server 4444` to start a minimal web server listening on
   port `4444`. On a separate terminal run `lsof | grep LISTEN` to print all listening
   processes and ports. Find that process pid and terminate it by running `kill <PID>`.

**Solution:**

```bash
python -m http.server 4444
lsof | rg LISTEN | rg python | sqk '{print $2}' | xargs kill
```
