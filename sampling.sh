#!/usr/bin/bash
rm ./data/*

#cek folder data
if [ ! -d data ]; then
	mkdir data
	mv file data/
else
	mv file data/
fi

#Mendownload file dari sumber $1 dan menyimpannya ke direktori /data/dengan_nama_$1
wget https://github.com/labusiam/dataset/raw/main/weather_data.xlsx -O ./data/$1

#Pengecekan atau validasi bahwa file csv sudah didownload
FILE=/home/fauziah/git/sampling_data/data/$1
if [ -f "$FILE" ]; then
       	echo "file exist"
	#Convert Sheet weather_2014 menjadi file weather_2014.csv
	in2csv ./data/$1 --sheet "weather_2014" > ./data/weather_2014.csv
	#Convert Sheet weather_2015 menjadi file weather_2015.csv
	in2csv ./data/$1 --sheet "weather_2015" > ./data/weather_2015.csv
	#Gabungkan Data weather 2014 dan 2015 menjadi 1 csv kemudian beri nama  weather.csv
	csvstack ./data/weather_2014.csv ./data/weather_2015.csv > ./data/weather.csv
	#Selain itu hapus file weather_data.xlsx 
	rm ./data/$1
else
       	echo "File $1 belum ada di folder data"
fi

#Pengecekan atau validasi bahwa file weather.csv sudah ada
FILE_CSV=/home/fauziah/git/sampling_data/data/weather.csv
if [ -f "$FILE_CSV" ]; then
        echo "file exist"
	#Sampling weather.csv dengan rate 0.3 kemudian disimpan ke dalam sample_weather.csv 
	awk -F ',' -r 0.3 ./data/weather.csv > ./data/sample_weather.csv
else
       	echo "File weather.csv belum ada di folder data"
fi
