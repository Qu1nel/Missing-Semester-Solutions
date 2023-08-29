# Solutions of Lecture 8

1. Most makefiles provide a target called `clean`. This isn’t intended to produce
   a file called `clean`, but instead to `clean` up any files that can be re-built
   by make. Think of it as a way to “undo” all of the build steps. Implement a
   clean target for the `paper.pdf` `Makefile` above. You will have to make the
   target [phony](https://www.gnu.org/software/make/manual/html_node/Phony-Targets.html).
   You may find the [`git ls-files`](https://git-scm.com/docs/git-ls-files) subcommand
   useful. A number of other very common make targets are listed
   [here](https://www.gnu.org/software/make/manual/html_node/Standard-Targets.html#Standard-Targets).

   **Solution:**

   ```make
    paper.pdf: paper.tex plot-data.png
       pdflatex paper.tex

    plot-%.png: %.dat plot.py
       ./plot.py -i "$*.dat" -o "$@"

    clean:
       rm -vrf paper.log
       rm -vrf paper.aux
       rm -vrf plot-data.png
       rm -vrf paper.pdf
   ```

2. Set up a simple auto-published page using GitHub Pages. Add a GitHub Action
   to the repository to run `shellcheck` on any shell files in that repository
   (here is one way to do it). Check that it works!

   **Solution:**

   ```yaml
   on:
     push:
       branches:
         - main

   name: "Trigger: Push action"
   permissions: {}

   jobs:
     shellcheck:
       name: Shellcheck
       runs-on: ubuntu-latest
       steps:
         - uses: actions/checkout@v3
         - name: Run ShellCheck
           uses: ludeeus/action-shellcheck@master
   ```

3. Build your own GitHub action to run proselint or write-good on all the .md
   files in the repository. Enable it in your repository, and check that it
   works by filing a pull request with a typo in it.

   **Solution:**

   ```yaml
   ``name: Check for typos

    on:
      pull_request:
        branches: ["main"]

    jobs:
      check:
        runs-on: ubuntu-latest
        steps:
          - name: Checkout
            uses: actions/checkout@v3

          - name: Install npm
            uses: actions/setup-node@v3

          - name: Install write-good
            run: npm install -g write-good

          - name: Run write-good for all *.md filse
            run: write-good *.md`
   ```

incorect word.
