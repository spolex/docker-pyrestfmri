docker run --rm kaczmarj/neurodocker:master generate docker --base neurodebian:stretch-non-free\
 --label maintainer="Inigo Sanchez <jisanchez003@ehu.es>"\
 --pkg-manager apt\
 --install gcc g++ graphviz tree vim nano git octave\
 --fsl version=6.0.1\
 --ants version=2.3.1\
 --user elekin\
 --workdir='/home/elekin'\
 --run "mkdir ~/.conda"\
 --miniconda create_env=elekin\
	conda_install="traits jupyter jupyterlab matplotlib nibabel pip nitime numpy scikit-learn"\
	pip_install="https://github.com/nipy/nipype/tarball/master nilearn"\
 	activate=true\
 --run "mkdir -p ~/.jupyter && echo c.NotebookApp.ip = \'0.0.0.0\' > ~/.jupyter/jupyter_notebook_config.py"\
 --expose 8888 8888\
 --volume /home/elekin/datos:/home/hadoop/nfs-storage/00-DATASOURCES/00-FMRI\
 --volume /home/elekin/pyrestfmri:/home/hadoop/nfs-storage/03-WORKSPACE/pyrestfmri\
 --volume /home/elekin/results:/home/hadoop/nfs-storage/02-RESULTADOS/output\
 --cmd "/home/elekin/pyrestfmri/preprocess.py","-c","/home/elekin/pyrestfmri/conf/config_test.json"
