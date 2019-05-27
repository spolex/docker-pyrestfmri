source $1 
echo "$OUTPUT_PATH"
echo "$INPUT_PATH"
echo "$SUBJS"
echo "$CODE_PATH"
echo "$CONVERSOR"

docker run --rm -d -v "$INPUT_PATH":/data:ro \
-v "$OUTPUT_PATH":/output -v "$CODE_PATH":/code nipy/heudiconv:latest \
-d /data/{subject}/*/DICOM/*/*/* -s $SUBJS --ses 1 \
-f /code/convertall_elekin.py -c $CONVERSOR -o /output --overwrite
