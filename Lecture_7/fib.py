#!/usr/bin/env python
from functools import lru_cache

lru_cache


def fib0():
    return 0


def fib1():
    return 1


s = """def fib{}(): return fib{}() + fib{}()"""

if __name__ == "__main__":
    for n in range(2, 10):
        exec(s.format(n, n - 1, n - 2))
    for n in range(10):
        exec("fib{} = lru_cache(1)(fib{})".format(n, n))
    print(eval("fib9()"))
