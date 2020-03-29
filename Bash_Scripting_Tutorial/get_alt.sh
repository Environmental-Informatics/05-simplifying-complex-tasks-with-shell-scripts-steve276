#!/bin/bash
# check altitude of station data files

echo The name of this file is $0

#altitude=$(head -5 Station_01.txt | tail -1 | awk '{print $4}')

#echo $altitude

# or cat Station_01.txt | sed -n '5 p'

#cat /dev/stdin | sed -n '5 p' | awk '{print $4}'

altfile=Station_01.txt
altitude=$(cat $altfile | sed -n '5 p' | awk '{print $4}')
#echo $0
echo altitude is  $altitude

# for file in StationData/*
#...check whether alt is > 200
#...if > 200 copy file to directory x (must remove file path)
#...if directory x DNE, make directory x &&(and) cp file there

for file in StationData/*
    file = StationData/*

if [ 1 -eq "$(echo "$altitude >= 200" | bc)" ]
then
  echo altitude is gt 200
  if [ -d "HigherElevation/"] 
  then 
    cp $file HigherElevation/$(basename $file)
    echo $(basename $file) copied to HigherElevation directory 
  else
    mkdir HigherElevation/ && cp $file HigherElevation/$(basename $file)
    echo HigherElevation directory made and $(basename $file) copied to it
else
  echo altitude in $(basename $file) is lt 200
fi

echo
pwd



#
