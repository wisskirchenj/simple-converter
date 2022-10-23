#!/usr/bin/env bash
# converter stage 4

FILE_NAME="definitions.txt"
REGEX_NUMBER='^-?[0-9]+\.?[0-9]*$'

function print_menu() {
  echo """
Select an option
0. Type '0' or 'quit' to end program
1. Convert units
2. Add a definition
3. Delete a definition"""
}

function parse_definition() {
  token_count=${#command_line[@]}
  convert_command=${command_line[0]}
  convert_factor=${command_line[1]}
  regex_command='^[a-zA-Z]+_to_[a-zA-Z]+$'
}

function add_to_file() {
  echo $* >> $FILE_NAME
}

function add_definition() {
  correct_definition=false
  while ! $correct_definition; do
    echo "Enter a definition:"
    read -a command_line
    parse_definition
    if [ $token_count -ne 2 ] || [[ ! $convert_command =~ $regex_command ]] || [[ ! $convert_factor =~ $REGEX_NUMBER ]]; then
      echo "The definition is incorrect!"
    else
      correct_definition=true
    fi
  done
  add_to_file ${command_line[@]}
}

function list_file_with_line_numbers() {
  i=1
  while [ $i -le $lines ]; do
    echo $i'. '`sed -n $i'p' $FILE_NAME`
    (( i += 1 ))
  done
}


function delete_line_from_file() {
  if [ $1 -gt 0 ]; then
    sed -i '' $1'd' $FILE_NAME
  fi
}

function check_if_definitions() {
    regex="^0 .+$"
    if [ ! -e $FILE_NAME ] || [[ $(echo `wc $FILE_NAME`) =~ $regex ]]; then
      echo "Please add a definition first!"
      no_definition=1
      return
    fi
    no_definition=0
}

function determine_line() {
    echo $1
    regex="^([0-9]+) .*$"
    [[ $(echo `wc $FILE_NAME`) =~ $regex ]] && lines=${BASH_REMATCH[1]}

    list_file_with_line_numbers
    read line
    while [[ ! $line =~ ^[0-9]+$ ]] || [ $line -gt $lines ]; do
      echo "Enter a valid line number!"
      read line
    done
}

function delete_definition() {
  check_if_definitions
  if [ $no_definition == "1" ]; then
    return
  fi
  determine_line "Type the line number to delete or '0' to return"
  delete_line_from_file $line
}

function prompt_convert_value() {
  echo "Enter a value to convert:"
  read convert_value
  while [[ ! $convert_value =~ $REGEX_NUMBER ]]; do
    echo "Enter a float or integer value!"
    read convert_value
  done
}

function convert_from_line() {
  result=$(echo "scale=2; $2 * $3" | bc -l)
  printf "Result: %s\n" "$result"
}

function convert_units() {
  check_if_definitions
  if [ $no_definition == "1" ]; then
    return
  fi
  determine_line "Type the line number to convert units or '0' to return"
  if [ $line == "0" ]; then
    return
  fi
  prompt_convert_value
  convert_from_line `sed -n $line'p' $FILE_NAME` $convert_value
}

echo "Welcome to the Simple converter!"
print_menu
read choice
while [[ ! $choice =~ ^0|quit$ ]]; do
  case $choice in
    "1") convert_units;;
    "2") add_definition;;
    "3") delete_definition;;
    *) echo "Invalid option!";;
  esac
  print_menu
  read choice
done
echo "Goodbye!"
