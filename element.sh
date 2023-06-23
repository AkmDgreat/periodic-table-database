#!/bin/bash


PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

SHELL_ARG=$1

DISPLAY () {
    NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number='$ATOMIC_NUMBER'")
    SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number='$ATOMIC_NUMBER'")
    TYPE=$($PSQL "SELECT type FROM properties WHERE atomic_number='$ATOMIC_NUMBER'")
    MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number='$ATOMIC_NUMBER'")   
    MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number='$ATOMIC_NUMBER'")
    BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number='$ATOMIC_NUMBER'")
    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
}

#if the element is not present in DB or element DNE
IF_ELEMENT_DNE () {
    if [[ -z $ATOMIC_NUMBER ]]
    then
        echo "I could not find that element in the database."
    else
        DISPLAY
    fi    
}


#If no argument is passed with shell script
if [[ -z "$SHELL_ARG" ]]
then
    echo "Please provide an element as an argument."
fi

#If atomic number is passed as argument
if [[ $SHELL_ARG =~ [0-9] ]]
then
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number=$SHELL_ARG")
    IF_ELEMENT_DNE
fi

#If the element's symbol is passed as argument
if  [[ $SHELL_ARG =~ [A-Z][a-z]$ ]]
then
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$SHELL_ARG'")
    IF_ELEMENT_DNE
fi

#If the element name is passed as argument
if [[ $SHELL_ARG =~ [A-Z][a-z][a-z]+ ]]
then
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name='$SHELL_ARG'")
    IF_ELEMENT_DNE   
fi
