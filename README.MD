# IDEA EDU Course ...

Implemented in the Track 'Introduction to Command Line and Unix Shell' of hyperskill.org's JetBrains Academy.

## Technology / External Libraries

- bash 5.2.15 on macOS
- bash testing suite BATS (bats-core, bats-assert, bats-support)
- gnu-sed (brew installed ...)

## Repository Contents

The sources of main project tasks (5 stages) and testing.

## Run all tests

```bash
./runtests
```

## Program description

The toy project implements a unit converter with bash including menu and persistence functionality.

Stage 1: command syntax parsing

Stage 2: check and convert a value

Stage 3: menu loop to the application

Stage 4: complex menu workflow with many checks and loops to add and delete convert definitions to a definitions-file.

Stage 5: implement the last menu item to do the actual conversions.

Run tests using bats

Have fun!

## Project completion

Project was completed on 23.10.22.

## Progress

17.10.22 Project started - gitHub repo and project structure setup.

17.10.22 Stage 1 completed - array-handling, read into array, POSIX-regexp, bats-testing

18.10.22 Stage 2 completed - functionize, while-loop and use of basic calculator 'bc'

22.10.22 Stage 3 completed - menu loop functionality with choice evaluation

22.10.22 Stage 4 completed - complex workflow to add and delete convert definitions. 
used: sed, wc, case, BASH_REMATCH, ... a lot

23.10.22 Final stage 5 completed - reuse of stage 2 code and delete_def menu item. sed-implementation.
