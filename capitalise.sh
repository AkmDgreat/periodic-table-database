#!/bin/bash

#This script capitalises the first letter of all the entries of a column 

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

echo "$($PSQL "SELECT symbol FROM elements")" | while read SYMBOL 
do
    if [[ $SYMBOL =~ ^[a-z] ]]
    then
        CAPITALISED_SYMBOL=$(echo $SYMBOL | sed 's/^\(.\)/\U\1/')
        UPDATE_SYMBOL_RESULT=$($PSQL "UPDATE elements SET symbol='$CAPITALISED_SYMBOL' WHERE symbol='$SYMBOL'")
    fi
done