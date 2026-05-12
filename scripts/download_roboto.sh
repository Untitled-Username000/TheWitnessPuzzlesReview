#!/usr/bin/env bash
# Download Roboto font for MonoGame content pipeline
set -e
mkdir -p Content/font
cd Content/font
if [ ! -f Roboto-Regular.ttf ]; then
  echo "Downloading Roboto-Regular.ttf..."
  curl -L -o Roboto-Regular.ttf "https://github.com/google/fonts/raw/main/apache/roboto/Roboto%5Bwdth,wght%5D.ttf"
else
  echo "Roboto-Regular.ttf already exists."
fi
