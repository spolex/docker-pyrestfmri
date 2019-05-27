#environment variables
INPUT_PATH=$HOME/datos-dicom
OUTPUT_PATH=./heudiconv/output
CODE_PATH=./heudiconv/code
SUBJECTS_FILE_PATH=/home/hadoop/grametheus/docker-pyrestfmri/deleted_subjs.txt
#SUBJS="$(ls "$INPUT_PATH" | grep T0* | tr '\n' ' ')"
SUBJS="$(cat $SUBJECTS_FILE_PATH)"
CONVERSOR=none
#CONVERSOR=dcm2niix
