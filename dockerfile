FROM jupyter/r-notebook:599db13f9123

MAINTAINER Abeer Almutairy <abeer1uw@gmail.com>
LABEL authors="Abeer Almutairy"
USER root

# pre-requisites
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    fonts-dejavu \
    gfortran \
    gcc && apt-get clean && \
    rm -rf /var/lib/apt/lists/*
   

#RUN chown -R $NB_USER:users ./data
USER $NB_USER

#RUN chown -R $NB_USER:users ./data
#RUN chown -R $NB_USER:users ./figures
#RUN chown -R $NB_USER:users ./write


USER $NB_USER

#WORKDIR ${HOME}

RUN echo "c.NotebookApp.token = u''" >> $HOME/.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.iopub_data_rate_limit=1e22" >> $HOME/.jupyter/jupyter_notebook_config.py
RUN conda install -c marufr python-igraph 

#RUN conda install jupyter_contrib_nbextensions
RUN conda install -c conda-forge jupyter_contrib_nbextensions
#RUN pip install jupyter_contrib_nbextensions

RUN conda install -c conda-forge jupyter_nbextensions_configurator
#RUN pip install jupyter_nbextensions_configurator
RUN jupyter nbextensions_configurator enable --user

RUN pip install --upgrade pip
RUN pip install matplotlib
RUN pip install pathlib
RUN pip uninstall igraph
RUN pip install jgraph
RUN pip install MulticoreTSNE
RUN pip install scanpy.api

RUN pip install scanpy-1.1
RUN pip install anndata==0.6.4
RUN pip install numpy==1.13.1
RUN pip install python-igraph==0.7.1
RUN pip install louvain==0.6.1 
RUN pip install pandas==0.22.0

# Install Tini
RUN conda install --quiet --yes 'tini=0.18.0' && \
    conda list tini | grep tini | tr -s ' ' | cut -d ' ' -f 1,2 >> $CONDA_DIR/conda-meta/pinned && \
    conda clean -tipsy && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

# Install Jupyter Notebook
# Generate a notebook server config
# Cleanup temporary files
# Correct permissions
# Do all this in a single RUN command to avoid duplicating all of the
# files across image layers when the permissions change
RUN conda install --quiet --yes \
    'notebook=5.6.*' \
    conda clean -tipsy && \
    jupyter labextension install @jupyterlab/hub-extension@^0.11.0 && \
    npm cache clean --force && \
    jupyter notebook --generate-config && \
    rm -rf $CONDA_DIR/share/jupyter/lab/staging && \
    rm -rf /home/$NB_USER/.cache/yarn && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

  
WORKDIR /home/jovyan
ADD . /home/jovyan
