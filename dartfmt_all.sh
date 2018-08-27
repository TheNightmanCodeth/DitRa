#!/bin/bash

########################
# Run dartfmt on every file in lib/
########################

for file in $(find lib/ -name '*.dart'); do
	dartfmt $file > $file.fmt
done

####
# If --clean is passed, delete all .fmt files
if [ $1 == '--clean' ]; then
	for file in $(find lib/ -name '*.fmt'); do
		rm $file
	done
fi

####
# If --help or -h is passed, tell the user what this script does
if [ $1 == '--help' ] || [ $1 == '-h' ]; then
	echo "This script will run dartfmt on every .dart file in the lib directory"
	echo ""
	echo "To use: ./dartfmt"
	echo "To delete all .fmt files: ./dartfmt --clean"
	echo "You will need to copy the contents of every .fmt file into their respective .dart file"
	echo "Make sure nothing breaks during transfer(:"
fi
