#!/bin/bash -f
# Author           : Adam Sobczuk ( s188656@student.pg.edu.pl )
# Created On       : 06.01.2022
# Last Modified By : Adam Sobczuk ( s188656@student.pg.edu.pl )
# Last Modified On : 06.01.2022 
# Version          : 1.0 
#
# Description      : Script packages files in three different formats using zenity
# 
#
# Licensed under GPL (see /usr/share/common-licenses/GPL for more # details or contact the Free Software Foundation for a copy)
while getopts hv OPT; do #function to enable options in running the script in the terminal
	case $OPT in 
		h) echo "Help manual: 
		1.First choose which format do you want (zip, tar or bzip2) 
		2.Remember to write the format exactly as they are without any uppercase letters 
		3. If you chose bzip2 chose then the path of the only file you want to pack 
		4.If you chose zip or tar however you have to write the name of the packaged files and you have to choose the directory of the files you want to pack 
		5. If you are certain and exploited all options choose pack 
		6. Your files will be pack and you can chose to pack another or chose finish to end the program" ; exit 1 ;;
		v) echo "Version: 1.0, Author: Adam Sobczuk email: s188656@student.pg.edu.pl " ; exit 1 ;;
		*) echo "Unknown option" ; exit 1 ;;
	esac
done
#function to implement the zenity menu
option() {
OPTION=`zenity --list --column=Menu "${MENU[@]}" --width 400 --height 300` 
}
while [ "$OPTION" != "Finish" ]
do
 MENU=("Format:$FORMAT" "File name:$NAME" "Directory:$DIRECTORY" "Path of file(for bzip2):$PATTH" "Pack" "Finish")
	clear
	option
	case $OPTION in
		"Format:"*) FORMAT=`zenity --entry --text "Enter which format you'd like to package the files: zip, tar, bzip2(note that with bzip2 you can only pack one file)"`;;
		"File name:"*) NAME=`zenity --entry --text "Enter the name of the compressed files"`;;
		"Directory:"*) DIRECTORY=`zenity --file-selection --directory`;;
		"Path of file(for bzip2):"*) PATTH=`zenity --file-selection`;;
		"Finish"*) echo "Ending the program";;
	esac
	if [ "$OPTION" == "Pack" ] 
  	then
  		if [ "$FORMAT" == "zip" ]
  			then 
  			if [ -n "$NAME" ] #additional security if the variable isn't full
  				then
  				if [ -n "$DIRECTORY" ] #additional security if the variable isn't full
  				then
  				zip -r $NAME $DIRECTORY
  				fi 
  			fi
  		fi
  		if [ "$FORMAT" == "tar" ]
  			then
  			if [ -n "$NAME" ] #additional security if the variable isn't full
  				then
  				if [ -n "$DIRECTORY" ] #additional security if the variable isn't full
  				then
  				tar cvzf $NAME.tar.gz $DIRECTORY
  				fi 
  			fi 
  		fi
  		if [ "$FORMAT" == "bzip2" ]
  			then
  			if [ -n "$PATTH" ] #additional security if the variable isn't full
  				then
  				bzip2 --keep $PATTH 
  			fi 
  		fi
  	fi
done
