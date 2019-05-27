#environment variables
INPUT_PATH=$HOME/datos-dicom
OUTPUT_PATH=$HOME/datos-niix-test
CODE_PATH=$HOME/docker-pyrestfmri/heudiconv/code
SUBJECTS_FILE_PATH=$HOME/docker-pyrestfmri/deleted_subjs.txt
#SUBJS="$(ls "$INPUT_PATH" | grep T0* | tr '\n' ' ')"
SUBJS="$(cat $SUBJECTS_FILE_PATH)"
#CONVERSOR=none
CONVERSOR=dcm2niix
