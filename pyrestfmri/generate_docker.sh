#!/usr/bin/env bash
docker run --rm kaczmarj/neurodocker:master generate docker --base neurodebian:stretch-non-free\
 --label maintainer="Inigo Sanchez <jisanchez003@ehu.es>"\
 --pkg-manager apt\
 --install gcc g++ graphviz tree vim nano git octave htop\
 --fsl version=6.0.1\
 --ants version=2.3.1\
 --user elekin\
 --workdir='/home/elekin'\
 --run "mkdir ~/.conda"\
 --miniconda create_env=elekin\
	conda_install="traits jupyter jupyterlab matplotlib nibabel pip nitime numpy scikit-learn networkx scipy"\
	pip_install="https://github.com/nipy/nipype/tarball/master nilearn niwidgets"\
 	activate=true\
 --run "mkdir -p ~/.jupyter && echo c.NotebookApp.ip = \'0.0.0.0\' > ~/.jupyter/jupyter_notebook_config.py"\
 --expose 8888 8888\
 --volume /home/elekin/datos\
 --volume /home/elekin/pyrestfmri\
 --volume /home/elekin/results\
 --cmd "/home/elekin/pyrestfmri/preprocess.py","-c","/home/elekin/pyrestfmri/conf/config_test.json"