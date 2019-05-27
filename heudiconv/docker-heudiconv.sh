source heudiconv/env.sh
echo "$OUTPUT_PATH"
echo "$INPUT_PATH"
echo "$SUBJS"

docker run --rm -d -v "$INPUT_PATH":/data:ro \
-v "$OUTPUT_PATH":/output nipy/heudiconv:latest \
-d /data/{subject}/*/DICOM/*/*/* -s $SUBJS --ses 1 \
-f /output/code/convertall_elekin.py -c $CONVERSOR -o /output --overwrite
