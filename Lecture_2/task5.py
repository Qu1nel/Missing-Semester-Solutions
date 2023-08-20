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
