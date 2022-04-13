#!/bin/bash

# conda install --yes -c conda-forge jupyterlab
# conda clean --all --yes

jupyter labextension install @jupyter-widgets/jupyterlab-manager
jupyter labextension install jupyter-matplotlib
python -m ipykernel install --user --name "${ENV_NAME}" --display-name "${ENV_NAME}"
