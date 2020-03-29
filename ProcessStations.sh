#!/bin/bash
# Saves station data at elevation >200 to HigherElevation directory

echo The name of this file is $0

#PartI: separate out high elevation stations

#altitude=$(head -5 Station_01.txt | tail -1 | awk '{print $4}')
# or cat Station_01.txt | sed -n '5 p'


for file in StationData/*
do
  altitude=$(cat $file | sed -n '5 p' | awk '{print $4}')
  echo altitude in $(basename $file) is $altitude

  if [ 1 -eq "$(echo "$altitude >= 200" | bc)" ]
  then
    echo altitude is gt 200
    if [ -d "HigherElevation/" ] 
    then 
      cp $file HigherElevation/$(basename $file)
      echo $(basename $file) copied to HigherElevation directory 
    else
      mkdir HigherElevation/ && cp $file HigherElevation/$(basename $file)
      echo HigherElevation directory made and $(basename $file) copied to it
    fi
  else
    echo altitude in $(basename $file) is lt 200
  fi
done

echo
echo Done separating station data


#PartII: plot station locations and highlight high elevation stations
#
