docker run --rm kaczmarj/neurodocker:master generate docker --base neurodebian:stretch-non-free\
 --label maintainer="Inigo Sanchez <jisanchez003@ehu.es>"\
 --pkg-manager apt\
 --install gcc g++ graphviz tree vim nano git octave\
# --ants version=2.2.0\
 --fsl version=6.0.1\
 --miniconda env_name=elekin\
	conda_install="python=3.6 traits jupyter jupyterlab matplotlib nibabel pip nitime numpy spyder dcm2niix"\
	pip_install="https://github.com/nipy/nipype/tarball/master https://github.com/INCF/pybids/tarball/master nilearn "\
	create_env="elekin"\
	activate=true\
 --run-bash "source activate elekin"\
 --run "mkdir -p ~/.jupyter && echo c.NotebookApp.ip = \'0.0.0.0\' > ~/.jupyter/jupyter_notebook_config.py"\
 --expose 8888 8888\
 --volume $HOME/datos-dicom:$HOME/datos-dicom\
 --volume $HOME/pyrestfmri:$HOME/pyrestfmri\
 --volume $HOME/preproc:$HOME/preproc\
 --workdir $HOMEY/pyrestfmri\
 --cmd python preprocess.py
