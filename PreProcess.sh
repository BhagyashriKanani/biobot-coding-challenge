#!/bin/bash

usage () {
        echo "USAGE  : ${0}"
        echo "Pass 4 arguments to the script"
        echo "First Argument: -input"
        echo "Second Argument: input file location"
        echo "Third Argument: -hdfs-dir"
        echo "Fourth Argument: hdfs file location"
	exit 1
}

if [ $# != 4 ]
then
        usage
        exit 1
fi

while [ $# -gt 0 ]
do

    case "$1" in
        -i*) INPUTFILE=${2};;
	-h*) HDFS_DIR=${2};;
        -*) usage
    esac
    shift
done


INPUT_FILE=`basename "${INPUTFILE}"`
echo "Loading ${INPUTFILE} into hdfs dir"

hdfs dfs -put "${INPUTFILE}" "${HDFS_DIR}"

#### Removing new line characters from the JSON file
#### Intention is load the file as text input file into hive #### table

sed -i 's/\n//g' "${INPUTFILE}"

exit 0


