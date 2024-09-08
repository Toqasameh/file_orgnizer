#!/usr/bin/bash


############################################                      script info                 ###############################################

# script purpose : 
# The goal of this project is to create a Bash script that organizes files in a specified directory based on their file types into separate sub-directories
# This can be useful to keep your directories clean and tidy by automatically sorting files into appropriate categories.

############################################  function declration & glopal varibles & sourcing files   ##############################################


declare DIRECTORY_PATH=$1
declare LOG_FILE=File_Orgnizer.log


###########################################    Function to move files      #######################################

function Move_File(){

  mv "./$DIRECTORY_PATH/$1" "./$DIRECTORY_PATH/$2"

}

###########################################  Function to check if directory exist or not     #######################################


function check_Directory(){

 if [ ! -d "./$DIRECTORY_PATH/${1}" ]; then
 mkdir "./$DIRECTORY_PATH/$1"
 Move_File $2 $1
 else
 Move_File $2 $1
 fi
 
}

###########################################         #######################################

function File_Orgnizer(){

declare FILE_NAME 
declare FILE_EXTENSION 
declare FIRST_CHAR

# Make sure path ends with /
for directory in "$DIRECTORY_PATH/"*; do

if [ -f "$directory" ]; then

 FILE_NAME="${directory##*/}"
 FILE_EXTENSION="${directory##*.}"
 
 if [[ ".$FILE_EXTENSION" == "$directory" ]] || [[ "$FILE_EXTENSION" == "unknown" ]] || [[ "$FIRST_CHAR" = "." ]]; then
       FILE_EXTENSION="misc"
fi

 check_Directory $FILE_EXTENSION  $FILE_NAME

 fi

done

}


###########################################################       main function         ############################################################### 
function main(){

 if [ ! -d "$DIRECTORY_PATH" ]; then
    echo "directory $DIRECTORY_PATH dose not exists" >>$LOG_FILE
    error 1
 fi   

 File_Orgnizer

}
###########################################################      calling main        ##################################################################### 
main
