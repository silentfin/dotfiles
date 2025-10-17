#!/bin/bash

# Simple version - always open terminal and run
TERMINAL="alacritty"  # Change to your terminal

$TERMINAL -e bash -c "
    cd $HOME/cs/softwares/sss || exit 1
    source .venv/bin/activate
    tput civis
    python3 main.py
    tput cnorm
    read -n 1
"


# doesnt works properly need fixes