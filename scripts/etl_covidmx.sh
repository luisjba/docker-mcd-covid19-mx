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
            if [ ! -f $output ]; then
                echo "File $output already downloaded"
                return 0
            fi
            echo "Downloading $url"
            curl -o "$output" $url
            if [ $? -eq 0 ]; then
                echo "Sucessful Downloaded into $output"
                return 0
            fi
            echo "Download failed"
            return 3
        fi
        echo "Missing parameter, call this function as $0 $url output"
        return 2
    fi
    echo "Missing parameter, call this function as $0 url output"
    return 1
}

function unzip_covid_data(){
    # Function to unzip the file
    # arg1: The zip file
    local zip_file=$1
    if [ -n "$url" ]; then
        # check if akready unziped
    fi
    echo "Missing parameter, call this function as $0 zip_file"
    return 1
}

[ -d $COVID_DATA_HOME ] || mkdir -p $COVID_DATA_HOME
COVID_DESTINATION_ZIP_FILE_OUTPUT="$COVID_DATA_HOME/$COVID_DESTINATION_ZIP_FILE"
download_covid_data $COVID_DATA_URL "$COVID_DESTINATION_ZIP_FILE_OUTPUT"
if [ $? -eq 0 ]; then
    unzip_covid_data "$COVID_DESTINATION_ZIP_FILE_OUTPUT"
fi



