#!/bin/bash

myArray=(0 1 2 3 "Hello" "World")

#prints index 3 of array
printf "${myArray[3]}\n\n"

#prints the lenght of the array 
printf "${#myArray[*]}\n\n"

#prints values from an array starting from n index
n=2
printf "${myArray[*]:n}\n\n"

#prints a specific range 
n=1
m=3
printf "${myArray[*]:n:m}\n\n"

#update an array
myArray+=(6 7 8)
printf "${myArray[7]}\n\n"

#associative array
declare -A Array
Array=( [name]=Alex [age]=26 )
printf "${Array[name]}\n\n"

#string manipulation
str="Scripting using bash even though I have zsh"
printf "${str}\n\n" #lenght
printf "${str/Scripting/Programming}\n\n" #replace
printf "${str:6:9}\n\n" #from which index, how many to print
printf "${str^^}\n\n" #toupper
printf "${str,,}\n\n" #tolower

#USER INTERACTION
#basic input
read var_name
printf "You entered $var_name, am I right?\n\n"

#input with prompt

read -p "Input your name: " NAME
printf "Sup, my $NAME!\n\n"

#arithmetic operations use let
#assignment for arithmetic operations use (( )) example
((a=5*10))
printf "$a\n\n"

#conditional statements
#if uses [] for condition
# -gt = greater than
# -lt = less than
# -eq = equal than == as well
# -ge = greater than or equal to
# -le = less than or equal to
# -ne = not equal != as well
