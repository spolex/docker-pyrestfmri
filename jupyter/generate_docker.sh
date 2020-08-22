#!/usr/bin/env bash
docker run --rm kaczmarj/neurodocker:master generate docker --base neurodebian:stretch-non-free\
 --label maintainer="Inigo Sanchez <jisanchez003@ehu.es>"\
 --pkg-manager apt\
 --install gcc g++ graphviz tree vim git htop\
 --fsl version=5.0.8\
 --ants version=2.3.1\
 --user elekin\
 --user root\
 --run-bash "usermod -u 1001 elekin"\
 --user elekin\
 --miniconda env_name=elekin\
	conda_install="python=3.6 traits jupyter matplotlib nibabel pip nitime numpy dcm2niix scikit-learn tensorflow=2.2.0 mkl pygpu pandas"\
	pip_install="https://github.com/nipy/nipype/tarball/master https://github.com/INCF/pybids/tarball/master nilearn git+git://github.com/nipy/niwidgets/ nxpd seaborn git+https://github.com/tensorflow/docs tables"\
	create_env="elekin"\
	activate=true\
 --run-bash "usermod -u 1001 elekin"\
 --run-bash "source activate elekin"\
 --run "mkdir -p ~/.jupyter && echo c.NotebookApp.ip = \'0.0.0.0\' > ~/.jupyter/jupyter_notebook_config.py"\
 --expose 8888 8888\
 --cmd "jupyter-notebook"
