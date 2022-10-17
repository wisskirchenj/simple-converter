#!/usr/bin/env bash
# converter stage 1

echo "Enter a definition:"
read -a command_line
token_count=${#command_line[@]}
convert_command=${command_line[0]}
convert_value=${command_line[1]}
regex_command='^[a-zA-Z]+_to_[a-zA-Z]+$'
regex_number='^-?[0-9]+\.?[0-9]*$'
if [ $token_count == 2 ] && [[ $convert_command =~ $regex_command ]] && [[ $convert_value =~ $regex_number ]]; then
  echo "The definition is correct!"
else
  echo "The definition is incorrect!"
fi