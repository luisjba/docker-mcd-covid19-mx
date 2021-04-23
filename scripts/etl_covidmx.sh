#!/bin/bash
# MAINTAINER: Jose Luis Bracamonte A. <luisjba@gmail.com>
# Date Created: 2021-04-22
# Las Updated: 2021-04-22
cat >/etc/motd <<EOL
v 1.0
 _          _       _      _  _
| |_  _ _  | | _ _ <_> ___<_>| |_  ___
| . \| | | | || | || |<_-<| || . \<_> |
|___/\_  | |_| ___||_|/__/| ||___/<___|
     <___|               <__|
This docker Instance is created to run a Jupyter Notebook
based from jupyter/scipy-notebook:584f43f06586
official site https://jupyter-docker-stacks.readthedocs.io/en/latest/index.html
-------------------------------------------------------------------------
This hook script is executed before Jupyter Notebook starts in order
to perform ETL(Extract Transform Load) of COVID DATA of Mexico.
Python version: `python --version`
MAINTAINER: Jose Luis Bracamonte Amavizca. <luisjba@gmail.com>
-------------------------------------------------------------------------
EOL
cat /etc/motd
set -e
function download_covid_data(){
    # Function to downaload the covid file
    # arg1: The URL to download
    # arg2: The output file name
    local url=$1
    local output=$2
    if [ -n "$url" ]; then
        if [ -n "$output" ]; then
            if [ -f $output ]; then
                echo "File $output already downloaded"
                return 0
            fi
            echo "Downloading $url"
            curl -o "$output" $url
            if [ $? -eq 0 ]; then
                echo "Sucessful Downloaded into $output"
                return 0
            fi
            >&2 echo "Download failed"
            return 3
        fi
        >&2 echo "Missing parameter, call this function as $0 $url output"
        return 2
    fi
    >&2 echo "Missing parameter, call this function as $0 url output"
    return 1
}
function unziped_covid_filename(){
    pushd "$COVID_DATA_HOME"
    local covid_filename=$(ls -1 *COVID19MEXICO.csv | grep -E "^2([0-9]+){5}(COVID19MEXICO.csv)$" | head -n 1)
    local ret_code=$([ -n "$covid_filename" ] && echo "0" || echo "1")
    [ $ret_code -eq 0 ] && echo "$covid_filename"
    popd
    return $ret_code
}

function unzip_covid_data(){
    # Function to unzip the file
    # arg1: The zip file
    local zip_file=$1
    if [ -n "$zip_file" ]; then
        if [ ! -f $zip_file ]; then
            >&2 echo "File $zip_file not found"
            return 2
        fi
        # check if already unziped
        local covid_filename=$(unziped_covid_filename)
        if [ -n "$covid_filename" ]; then
            echo "File already unziped"
            echo "$COVID_DATA_HOME/$covid_filename"
            return 0
        fi
        unzip "$zip_file"
        return $?
    fi
    >&2 echo "Missing parameter, call this function as $0 zip_file"
    return 1
}
function analize_covid_data(){
    # Function to analize The Covid data and produce the csv outputs
    # arg1: The CSV CVID19 file
    local csv_covid19=$1
    if [ -n "$csv_covid19" ]; then
    fi
    >&2 echo "Missing parameter, call this function as $0 csv_covid19"
    return 1
}

[ -d $COVID_DATA_HOME ] || mkdir -p $COVID_DATA_HOME
pushd "$COVID_DATA_HOME"
COVID_DESTINATION_ZIP_FILE_OUTPUT="$COVID_DATA_HOME/$COVID_DESTINATION_ZIP_FILE"
download_covid_data $COVID_DATA_URL "$COVID_DESTINATION_ZIP_FILE_OUTPUT"
if [ $? -eq 0 ]; then
    unzip_covid_data "$COVID_DESTINATION_ZIP_FILE_OUTPUT"
    if [ $? -eq 0 ]; then
        local csv_covid19=$(unziped_covid_filename)
        analize_covid_data "$csv_covid19"
    fi
fi
popd



