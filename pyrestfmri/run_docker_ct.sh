docker run \
 -v /home/elekindatos:/home/elekin/data \
 -v /home/elekin/output:/home/elekin/output \
 -v /home/elekin/pyrestfmri:/home/elekin/pyrestfmri \
 -v /home/elekin/pyrestfmri/notebooks:/home/elekin/notebooks \
 -p 8888:8888 -i -t pve.eastonlab.org:30500/pyrestfmri/pyrestfmri-service:development
