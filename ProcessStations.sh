#!/bin/bash
# extracts soil moisture station elevation and location data from a directory, plots localtion data, and generates three types of image files of the station marker plot


#PartI: separate out high elevation stations

#altitude=$(head -5 Station_01.txt | tail -1 | awk '{print $4}')
# or cat Station_01.txt | sed -n '5 p'


for file in StationData/*
do
  altitude=$(cat $file | sed -n '5 p' | awk '{print $4}')
  #echo altitude in $(basename $file) is $altitude

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

# separate loction data for all stations, longitude * -1 to set proper location
awk '/Longitude/ {print -1 * $NF}' StationData/Station_*.txt > Long.list
awk '/Latitude/ {print $NF}' StationData/Station_*.txt > Lat.list
paste Long.list Lat.list > AllStation.xy
echo lats and longs from all stations copied

# separate loction data for higher elevation stations
awk '/Longitude/ {print -1 * $NF}' HigherElevation/Station_*.txt > HE_Long.list
awk '/Latitude/ {print $NF}' HigherElevation/Station_*.txt > HE_Lat.list
paste HE_Long.list HE_Lat.list > HEStation.xy
echo lats and longs from high elevation stations copied

#module purge
module load gmt
#gmt set PROJ_LENTH_UNIT = inch

gmt pscoast -JU16/4i -R-93/-86/36/43 -B2f0.5 -Cl/blue -Df -Ia/blue -Na/orange -P -K -V > SoilMoistureStations.ps
gmt psxy AllStation.xy -J -R -Sc0.15 -Gblack -K -O -V >> SoilMoistureStations.ps
gmt psxy HEStation.xy -J -R -Sc0.05 -Gred -O -V >> SoilMoistureStations.ps
# modifications to plot template
# -Cl/blue fills lakes[l] with blue
# -Df sets resolution of drawn coastlines and political boundaries to full[f]
# -Sc0.05 makes high elevation markers smaller than all station markers to highlight them, S-size, c-circle, 0.05<0.15
 

#PartIII: convert postscript file to EPSI to TIFF image

ps2epsi SoilMoistureStations.ps [SoilMoistureStations.epsi]

convert [SoilMoistureStations.epsi] -density 150 SoilMoistureStations.TIF
