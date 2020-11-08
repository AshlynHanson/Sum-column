#!/bin/bash

# Ashlyn Hanson
# This program calculates the sum of the values in a specified column
# of a specified file. This script accepts a filename of some csv file
# delimited by tabs as its first argument and a column number as the
# second argument. The csv file is assumed to have a header line.
# The sript first checks that the first argument is
# a file and if it is not it prints out that the file does not exist
# and the exit code would be 3. If the file does exist the script
# checks that the number of columns in the csv file is greater
# than or equal to the column number inputed as the second argument
# and greater than 0.
# If not it prints out that the column does not exist and exits 2.
# The script iterates through each number in the column dropping
# the first line with the headers. If the value is a number than it
# it is added to the sum otherwise the script prints out that the
# column does not have integers and exits with 1. The sum of the
# values in the chosen column are printed to the screen.

if [[ $# -eq 2 ]]
then
  if [[ -f $1 ]]
  then
    # Gets the number of columns in the file by counting
    # the number of items in the header
    fileCount=$(head -1 $1 |tail -1 |tr '\t' '\n' |wc -l)

    # checks that the requested column is within the range
    # of columns in the csv file
    if [[ fileCount -ge $2 && $2 -gt 0 ]]
    then
      sum=0
      # the requested column without the header row
      column=$(cut -f$2 $1 | tail -n +2)
      anyNumber='^[+-]?[0-9]$'
      for number in $column
      do
        if [[ $number =~ $anyNumber ]]
	then
	  (( sum += number ))
	  else
	    echo "That column does not have integers"
	    exit 1
	  fi
      done
      echo "The total sum of values in the column $2 is $sum"
    else
      echo "Column $2 does not exist"
      exit 2
    fi
  else
    echo "File $1 does not exist"
    exit 3
  fi
else
  echo "Usage: $0 [filename] [Column Number]"
fi
exit 0
