#!/usr/bin/env bash
# converter stage 3

function print_menu() {
  echo """
Select an option
0. Type '0' or 'quit' to end program
1. Convert units
2. Add a definition
3. Delete a definition"""
}

echo "Welcome to the Simple converter!"
print_menu
read choice
while [[ ! $choice =~ ^0|quit$ ]]; do
  case $choice in
    "1" | "2" | "3") echo "Not implemented!";;
    *) echo "Invalid option!";;
  esac
  print_menu
  read choice
done
echo "Goodbye!"
