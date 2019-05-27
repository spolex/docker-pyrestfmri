docker run ^
 -v %cd%/datos:/home/elekin/data^
 -v %cd%/output:/home/elekin/output^
 -v %cd%/pyrestfmri:/home/elekin/pyrestfmri^
 -v %cd%/pyrestfmri/notebooks:/home/elekin/notebooks^
 -p 8888:8888 -i -t spolex/pyrestfmri:0.1