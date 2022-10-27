#!/bin/bash

for i in "$@"
do
case $i in
    --model=*)
    MODEL="${i#*=}"
    ;;
    --t=*)
    TARGET="${i#*=}"
    ;;
    *)
        # unknown option
    ;;
esac
done


VARS=( $(cut -d ' ' -f1 .env.$MODEL) )

DART_DEFINES=""
for (( i = 0; i < ${#VARS[@]}; i++ )); do
    DART_DEFINES+=" --dart-define=${VARS[i]}"
done

echo $1 'and' $2
echo $DART_DEFINES
#cd app
#if [ $1 == 'run' ]
#then
#  fvm flutter $1 -t $TARGET $DART_DEFINES
#fi
#if [ $1 == 'build' ]
#then
#  fvm flutter $1 $2 -t $TARGET $DART_DEFINES
#fi