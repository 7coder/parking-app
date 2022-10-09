#!/bin/bash

ENV_DIRECTORY = "./env"
DIST_DIRECTORY = "./dist"

if ! command -v node &> /dev/null
then
    echo "node js could not be found"
    exit
fi

echo "Node JS found. OK!"

if ! command -v python3 &> /dev/null
then
    echo "node js could not be found"
    exit
fi

echo "Python3 found. OK!"

echo "Install dependancies..."
cd ./parking-app-ui
npm install

echo "Build Vue project..."
npm run build

cd ../parking-app-api

if [ ! -d $DIST_DIRECTORY ]; then
  rm -rf $DIST_DIRECTORY
fi

echo "Move Vue dist..."
mv ../parking-app-ui/dist ./

if [ ! -d $ENV_DIRECTORY ]; then
  python3 -m venv $ENV_DIRECTORY
fi

source ./env/bin/activate

echo "Install Python packages..."
pip install -r requrements.txt

echo "Run application on Port 5000..."
python3 app.py


