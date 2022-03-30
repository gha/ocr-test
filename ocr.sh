#!/bin/bash

PWD=$(pwd)
IN_DIR=$PWD/in
TMP_DIR=$(date +%s)
CONTAINER=ocr-test_tesseract4_1

echo "Starting OCR"

docker exec -it $CONTAINER mkdir \-p ./$TMP_DIR/in
docker exec -it $CONTAINER mkdir \-p ./$TMP_DIR/out
docker cp $IN_DIR/* $CONTAINER:/home/work/$TMP_DIR/in

for f in $IN_DIR/*
do
bf=$(basename $f)
echo "Processing $bf"
docker exec -it $CONTAINER /bin/bash -c "cd ./$TMP_DIR; tesseract in/$bf out/$bf -l eng --psm 1 --oem 3 txt"
done

docker cp $CONTAINER:/home/work/$TMP_DIR/out/ $PWD
docker exec -it $CONTAINER rm \-r ./$TMP_DIR/

echo "Done"
