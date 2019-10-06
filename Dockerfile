# Your version: 0.6.0 Latest version: 0.6.0
# Generated by Neurodocker version 0.6.0
# Timestamp: 2019-10-06 16:01:01 UTC
# 
# Thank you for using Neurodocker. If you discover any issues
# or ways to improve this software, please submit an issue or
# pull request on our GitHub repository:
# 
#     https://github.com/kaczmarj/neurodocker

FROM neurodebian:stretch-non-free

ARG DEBIAN_FRONTEND="noninteractive"

ENV LANG="en_US.UTF-8" \
    LC_ALL="en_US.UTF-8" \
    ND_ENTRYPOINT="/neurodocker/startup.sh"
RUN export ND_ENTRYPOINT="/neurodocker/startup.sh" \
    && apt-get update -qq \
    && apt-get install -y -q --no-install-recommends \
           apt-utils \
           bzip2 \
           ca-certificates \
           curl \
           locales \
           unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
    && dpkg-reconfigure --frontend=noninteractive locales \
    && update-locale LANG="en_US.UTF-8" \
    && chmod 777 /opt && chmod a+s /opt \
    && mkdir -p /neurodocker \
    && if [ ! -f "$ND_ENTRYPOINT" ]; then \
         echo '#!/usr/bin/env bash' >> "$ND_ENTRYPOINT" \
    &&   echo 'set -e' >> "$ND_ENTRYPOINT" \
    &&   echo 'export USER="${USER:=`whoami`}"' >> "$ND_ENTRYPOINT" \
    &&   echo 'if [ -n "$1" ]; then "$@"; else /usr/bin/env bash; fi' >> "$ND_ENTRYPOINT"; \
    fi \
    && chmod -R 777 /neurodocker && chmod a+s /neurodocker

ENTRYPOINT ["/neurodocker/startup.sh"]

LABEL maintainer="Inigo Sanchez <jisanchez003@ehu.es>"

RUN apt-get update -qq \
    && apt-get install -y -q --no-install-recommends \
           gcc \
           g++ \
           graphviz \
           tree \
           vim \
           nano \
           git \
           octave \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV FSLDIR="/opt/fsl-6.0.1" \
    PATH="/opt/fsl-6.0.1/bin:$PATH"
RUN apt-get update -qq \
    && apt-get install -y -q --no-install-recommends \
           bc \
           dc \
           file \
           libfontconfig1 \
           libfreetype6 \
           libgl1-mesa-dev \
           libgl1-mesa-dri \
           libglu1-mesa-dev \
           libgomp1 \
           libice6 \
           libxcursor1 \
           libxft2 \
           libxinerama1 \
           libxrandr2 \
           libxrender1 \
           libxt6 \
           sudo \
           wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && echo "Downloading FSL ..." \
    && mkdir -p /opt/fsl-6.0.1 \
    && curl -fsSL --retry 5 https://fsl.fmrib.ox.ac.uk/fsldownloads/fsl-6.0.1-centos6_64.tar.gz \
    | tar -xz -C /opt/fsl-6.0.1 --strip-components 1 \
    && sed -i '$iecho Some packages in this Docker container are non-free' $ND_ENTRYPOINT \
    && sed -i '$iecho If you are considering commercial use of this container, please consult the relevant license:' $ND_ENTRYPOINT \
    && sed -i '$iecho https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/Licence' $ND_ENTRYPOINT \
    && sed -i '$isource $FSLDIR/etc/fslconf/fsl.sh' $ND_ENTRYPOINT \
    && echo "Installing FSL conda environment ..." \
    && bash /opt/fsl-6.0.1/etc/fslconf/fslpython_install.sh -f /opt/fsl-6.0.1 \
    && echo "Downgrading deprecation module per https://github.com/kaczmarj/neurodocker/issues/271#issuecomment-514523420" \
    && /opt/fsl-6.0.1/fslpython/bin/conda install -n fslpython -c conda-forge -y deprecation==1.* \
    && echo "Removing bundled with FSLeyes libz likely incompatible with the one from OS" \
    && rm -f /opt/fsl-6.0.1/bin/FSLeyes/libz.so.1

ENV ANTSPATH="/opt/ants-2.3.1" \
    PATH="/opt/ants-2.3.1:$PATH"
RUN echo "Downloading ANTs ..." \
    && mkdir -p /opt/ants-2.3.1 \
    && curl -fsSL --retry 5 https://dl.dropbox.com/s/1xfhydsf4t4qoxg/ants-Linux-centos6_x86_64-v2.3.1.tar.gz \
    | tar -xz -C /opt/ants-2.3.1 --strip-components 1

RUN test "$(getent passwd elekin)" || useradd --no-user-group --create-home --shell /bin/bash elekin
USER elekin

WORKDIR /home/elekin

RUN mkdir ~/.conda

ENV CONDA_DIR="/opt/miniconda-latest" \
    PATH="/opt/miniconda-latest/bin:$PATH"
RUN export PATH="/opt/miniconda-latest/bin:$PATH" \
    && echo "Downloading Miniconda installer ..." \
    && conda_installer="/tmp/miniconda.sh" \
    && curl -fsSL --retry 5 -o "$conda_installer" https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && bash "$conda_installer" -b -p /opt/miniconda-latest \
    && rm -f "$conda_installer" \
    && conda update -yq -nbase conda \
    && conda config --system --prepend channels conda-forge \
    && conda config --system --set auto_update_conda false \
    && conda config --system --set show_channel_urls true \
    && sync && conda clean --all && sync \
    && conda create -y -q --name elekin \
    && conda install -y -q --name elekin \
           "traits" \
           "jupyter" \
           "jupyterlab" \
           "matplotlib" \
           "nibabel" \
           "pip" \
           "nitime" \
           "numpy" \
           "scikit-learn" \
    && sync && conda clean --all && sync \
    && bash -c "source activate elekin \
    &&   pip install --no-cache-dir  \
             "https://github.com/nipy/nipype/tarball/master" \
             "nilearn"" \
    && rm -rf ~/.cache/pip/* \
    && sync \
    && sed -i '$isource activate elekin' $ND_ENTRYPOINT

RUN mkdir -p ~/.jupyter && echo c.NotebookApp.ip = \'0.0.0.0\' > ~/.jupyter/jupyter_notebook_config.py

EXPOSE 8888 8888

VOLUME ["/home/elekin/datos"]

VOLUME ["/home/elekin/pyrestfmri"]

VOLUME ["/home/elekin/results"]

CMD ["/home/elekin/pyrestfmri/preprocess.py,-c,/home/elekin/pyrestfmri/conf/config_test.json"]

RUN echo '{ \
    \n  "pkg_manager": "apt", \
    \n  "instructions": [ \
    \n    [ \
    \n      "base", \
    \n      "neurodebian:stretch-non-free" \
    \n    ], \
    \n    [ \
    \n      "label", \
    \n      { \
    \n        "maintainer": "Inigo Sanchez <jisanchez003@ehu.es>" \
    \n      } \
    \n    ], \
    \n    [ \
    \n      "install", \
    \n      [ \
    \n        "gcc", \
    \n        "g++", \
    \n        "graphviz", \
    \n        "tree", \
    \n        "vim", \
    \n        "nano", \
    \n        "git", \
    \n        "octave" \
    \n      ] \
    \n    ], \
    \n    [ \
    \n      "fsl", \
    \n      { \
    \n        "version": "6.0.1" \
    \n      } \
    \n    ], \
    \n    [ \
    \n      "ants", \
    \n      { \
    \n        "version": "2.3.1" \
    \n      } \
    \n    ], \
    \n    [ \
    \n      "user", \
    \n      "elekin" \
    \n    ], \
    \n    [ \
    \n      "workdir", \
    \n      "/home/elekin" \
    \n    ], \
    \n    [ \
    \n      "run", \
    \n      "mkdir ~/.conda" \
    \n    ], \
    \n    [ \
    \n      "miniconda", \
    \n      { \
    \n        "create_env": "elekin", \
    \n        "conda_install": [ \
    \n          "traits", \
    \n          "jupyter", \
    \n          "jupyterlab", \
    \n          "matplotlib", \
    \n          "nibabel", \
    \n          "pip", \
    \n          "nitime", \
    \n          "numpy", \
    \n          "scikit-learn" \
    \n        ], \
    \n        "pip_install": [ \
    \n          "https://github.com/nipy/nipype/tarball/master", \
    \n          "nilearn" \
    \n        ], \
    \n        "activate": true \
    \n      } \
    \n    ], \
    \n    [ \
    \n      "run", \
    \n      "mkdir -p ~/.jupyter && echo c.NotebookApp.ip = \\'"'"'0.0.0.0\\'"'"' > ~/.jupyter/jupyter_notebook_config.py" \
    \n    ], \
    \n    [ \
    \n      "expose", \
    \n      [ \
    \n        "8888", \
    \n        "8888" \
    \n      ] \
    \n    ], \
    \n    [ \
    \n      "volume", \
    \n      [ \
    \n        "/home/elekin/datos" \
    \n      ] \
    \n    ], \
    \n    [ \
    \n      "volume", \
    \n      [ \
    \n        "/home/elekin/pyrestfmri" \
    \n      ] \
    \n    ], \
    \n    [ \
    \n      "volume", \
    \n      [ \
    \n        "/home/elekin/results" \
    \n      ] \
    \n    ], \
    \n    [ \
    \n      "cmd", \
    \n      [ \
    \n        "/home/elekin/pyrestfmri/preprocess.py,-c,/home/elekin/pyrestfmri/conf/config_test.json" \
    \n      ] \
    \n    ] \
    \n  ] \
    \n}' > /neurodocker/neurodocker_specs.json