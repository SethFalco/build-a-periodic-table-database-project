#!/bin/bash
PSQL='psql --username freecodecamp --dbname periodic_table -t --no-align -c'

if [[ -z $1 ]]
then
  echo 'Please provide an element as an argument.'
  exit
fi

if [[ $1 =~ [0-9]+ ]]
then
  WHERE="WHERE atomic_number = $1"  
else
  WHERE="WHERE symbol = '$1' OR name = '$1'"
fi

DATA=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) $WHERE;")
