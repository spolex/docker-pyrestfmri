docker run --rm kaczmarj/neurodocker:master generate docker --base neurodebian:stretch-non-free\
 --label maintainer="Inigo Sanchez <jisanchez003@ehu.es>"\
 --pkg-manager apt\
 --install gcc g++ graphviz tree vim nano git octave\
 --fsl version=5.0.8\
 --ants version=2.3.1\
 --miniconda env_name=elekin\
	conda_install="python=3.6 traits jupyter jupyterlab matplotlib nibabel pip nitime numpy dcm2niix scikit-learn tensorflow mkl pygpu pandas"\
	pip_install="https://github.com/nipy/nipype/tarball/master https://github.com/INCF/pybids/tarball/master nilearn git+git://github.com/nipy/niwidgets/ nxpd seaborn"\
	create_env="elekin"\
	activate=true\
 --user elekin\
 --run-bash "source activate elekin"\
 --run "mkdir -p ~/.jupyter && echo c.NotebookApp.ip = \'0.0.0.0\' > ~/.jupyter/jupyter_notebook_config.py"\
 --expose 8888 8888\
 --volume /home/elekin/datos-dicom\
 --volume /home/elekin/pyrestfmri\
 --workdir /home/elekin/pyrestfmri\
 --cmd "jupyter-notebook"
