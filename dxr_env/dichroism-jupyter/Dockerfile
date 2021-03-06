# syntax = docker/dockerfile:1.2

# FROM ubuntu:16.04
FROM ubuntu:18.04

# Install utilities as root user
RUN apt-get update \
#  && apt-get install -y --no-install-recommends openssl wget curl git \
  && apt-get install -y wget git vim \
  && rm -rf /var/lib/apt/lists/*

# Need bash for "conda" scripts
SHELL [ "/bin/bash", "--login", "-c" ]

# Name of this project and its packaged module
ARG project_name=dichroism-jupyter
ENV PROJECT_NAME "${project_name}"
ARG module_name=dxr_env
ENV MODULE_NAME "${module_name}"
ARG module_proj_name=dichroism_jupyter
ENV MODULE_PROJ_NAME "${module_proj_name}"

# Source directories for this project
ENV MODULE_SRC_DIR=./"${MODULE_NAME}"
ENV IMAGE_SRC_DIR="${MODULE_SRC_DIR}"/"${PROJECT_NAME}"

# Create a non-root user
ARG username=chemla
ARG uid=1000
ARG gid=100
ENV USER $username
ENV UID $uid
ENV GID $gid
ENV HOME /home/$USER
RUN adduser --disabled-password \
  --gecos "Non-root user" \
  --uid $UID \
  --gid $GID \
  --home $HOME \
  $USER

# Copy files as root, configure for container user
COPY "${IMAGE_SRC_DIR}"/*.sh /usr/local/bin/"${PROJECT_NAME}"/
RUN chown $UID:$GID /usr/local/bin/"${PROJECT_NAME}"/*.sh && \
    chmod u+x /usr/local/bin/"${PROJECT_NAME}"/*.sh && \
    ln -s /usr/local/bin/"${PROJECT_NAME}"/*.sh /usr/local/bin/

# Install Miniconda as the non-root user
USER $USER

# install miniconda
ENV MINICONDA_VERSION latest
ENV CONDA_DIR $HOME/miniconda3
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-$MINICONDA_VERSION-Linux-x86_64.sh -O ~/miniconda.sh && \
    chmod +x ~/miniconda.sh && \
    ~/miniconda.sh -b -p $CONDA_DIR && \
    rm ~/miniconda.sh

# make non-activate conda commands available
ENV PATH=$CONDA_DIR/bin:$PATH

# make conda activate command available from /bin/bash --login shells
RUN echo ". $CONDA_DIR/etc/profile.d/conda.sh" >> ~/.profile

# make conda activate command available from /bin/bash --interative shells
RUN conda init bash

# create a project directory inside user home
ENV PROJECT_DIR $HOME/$PROJECT_NAME
RUN mkdir $PROJECT_DIR
WORKDIR $PROJECT_DIR

# Install docker image files
COPY --chown=$UID:$GID \
  "${IMAGE_SRC_DIR}"/*.py "${IMAGE_SRC_DIR}"/*.pem \
  "${IMAGE_SRC_DIR}"/*.yml "${PROJECT_DIR}"/
WORKDIR "${PROJECT_DIR}"

# Remove build-time ENV variables
RUN unset IMAGE_SRC_DIR MODULE_SRC_DIR

# Update the base conda environment
ENV CONDA_REMOVE_PKGS --force-pkgs-dirs
ENV CONDA_CLEAN_OPT $CONDA_REMOVE_PKGS
RUN conda update --name base --channel defaults conda

#---------------------------------------
# REPEAT this block for each environment

# Build the conda environment
ENV ENV_NAME=dbc_fastapi
ENV ENV_PREFIX $PROJECT_DIR/envs/"${ENV_NAME}"
RUN conda env create --prefix $ENV_PREFIX --file "${ENV_NAME}".env.yml --force && \
    conda clean --all --yes $CONDA_CLEAN_OPT

# run the postBuild script to install any JupyterLab extensions
RUN conda activate $ENV_PREFIX && \
    /usr/local/bin/postBuild.sh && \
    conda deactivate && \
    unset ENV_NAME ENV_PREFIX

# END REPEAT for each environment
#---------------------------------------

# Include packaged module for versioning
COPY --chown=$UID:$GID ./dist ./tmp/dist

#=======================================
# REPEAT this block for each environment

# Install packaged module for versioning
ENV ENV_NAME=dbc_fastapi
ENV ENV_PREFIX $PROJECT_DIR/envs/"${ENV_NAME}"
RUN conda activate $ENV_PREFIX && \
    /usr/local/bin/install_proj_pkgs.sh && \
    conda deactivate && \
    unset ENV_NAME ENV_PREFIX

# END REPEAT for each environment
#=======================================

# Cleanup after installation
RUN rm -rf ./tmp/dist
# Remove build-time ENV variables
RUN unset MODULE_PROJ_NAME

# Activate the project conda environment at shell startup
ARG default_env_name=dbc_fastapi
ENV DEFAULT_ENV_NAME="${default_env_name}"
ENV DEFAULT_ENV_PREFIX $PROJECT_DIR/envs/"${DEFAULT_ENV_NAME}"
RUN echo "" >> $HOME/.bashrc \
  && echo "conda activate $DEFAULT_ENV_PREFIX" >> $HOME/.bashrc \
  && echo "" >> $HOME/.bashrc

# Ensure that the Conda environment is properly activated at runtime
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]

# default command will launch JupyterLab server for development
CMD [ "jupyter", "lab", "--no-browser", "--ip", "0.0.0.0" ]
