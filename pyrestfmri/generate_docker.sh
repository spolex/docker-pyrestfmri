docker run --rm kaczmarj/neurodocker:master generate docker --base neurodebian:stretch-non-free\
 --label maintainer="Inigo Sanchez <jisanchez003@ehu.es>"\
 --pkg-manager apt\
 --install gcc g++ graphviz tree vim nano git octave\
 --ants version=2.2.0\
 --fsl version=6.0.1\
 --user=elekin\
 --copy ../pyrestfmri /home/elekin/pyrestfmri\
 --miniconda env_name=elekin\
	conda_install="python=3.6 traits jupyter jupyterlab matplotlib nibabel pip nitime numpy spyder dcm2niix"\
	pip_install="https://github.com/nipy/nipype/tarball/master https://github.com/INCF/pybids/tarball/master nilearn dcm2bids"\
	create_env="elekin"\
	activate=true\
 --run "mkdir ~/elekin"\
 --run-bash "source activate elekin"\
 --run "mkdir -p ~/.jupyter && echo c.NotebookApp.ip = \'0.0.0.0\' > ~/.jupyter/jupyter_notebook_config.py"\
 --run "mkdir /home/elekin/data && chmod 777 /home/elekin/data && chmod a+s /home/elekin/data"\
 --run "mkdir /home/elekin/output && chmod 777 /home/elekin/output && chmod a+s /home/elekin/output"\
 --run "mkdir /home/elekin/pyrestfmri && chmod 777 /home/elekin/pyrestfmri && chmod a+s /home/elekin/pyrestfmri"\
 --run "mkdir /home/elekin/notebooks && chmod 777 /home/elekin/notebooks && chmod a+s /home/elekin/notebooks"\
 --expose 8888 8888\
 --volume $HOME/datos-dicom:$HOME/datos-dicom
 --workdir $HOME\
 --cmd jupyter-notebook
