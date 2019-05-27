
docker run --rm -it -v $INPUT_PATH:/data:ro \
-v $OUTPUT_PATH:/output nipy/heudiconv:latest \
-d /data/{subject}/*/DICOM/*/*/* -s $SUBJS --ses 1 \
-f /output/code/convertall_elekin.py -c dcm2niix -o /output --overwrite
