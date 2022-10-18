#!/usr/bin/env bash
# converter stage 2

function parse_definition() {
  token_count=${#command_line[@]}
  convert_command=${command_line[0]}
  convert_factor=${command_line[1]}
  regex_command='^[a-zA-Z]+_to_[a-zA-Z]+$'
  regex_number='^-?[0-9]+\.?[0-9]*$'
}

echo "Enter a definition:"
read -a command_line
parse_definition
if [ $token_count -ne 2 ] || [[ ! $convert_command =~ $regex_command ]] || [[ ! $convert_factor =~ $regex_number ]]; then
  echo "The definition is incorrect!"
  exit
fi
echo "Enter a value to convert:"
read convert_value
while [[ ! $convert_value =~ $regex_number ]]; do
  echo "Enter a float or integer value!"
  read convert_value
done
result=$(echo "scale=2; $convert_factor * $convert_value" | bc -l)
printf "Result: %s\n" "$result"