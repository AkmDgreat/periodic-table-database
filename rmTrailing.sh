#!/bin/bash

#This script removes trailing zeros (in decimal numbers) of all the entries in a column 

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

echo "$($PSQL "SELECT atomic_mass FROM properties")" | while read ATOMIC_MASS
do
    ATOMIC_MASS_TRUNCATED=$(echo $ATOMIC_MASS | sed -E 's/(\.0*$|0*$)//')
    UPDATE_MASS_RESULT=$($PSQL "UPDATE properties SET atomic_mass=$ATOMIC_MASS_TRUNCATED WHERE atomic_mass=$ATOMIC_MASS")
done

#  sed 's/0*$//' will replace trailing 0s with nothing
#  as a result, 1.00000 is replaced with 1. (which is a problem)

#  sed -E 's/(\.0*$|0*$)//'
#  -> | is or operator. (-E is required to use or operator)
#  -> this regex replaces .0000 or 0000 with nothing
#  -> u need to escape period(.) with a backslash cuz period also means "any character"