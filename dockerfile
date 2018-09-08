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

#RUN conda install -c conda-forge jupyter_contrib_nbextensions
#RUN conda install jupyter_contrib_nbextensions
RUN conda install -c conda-forge jupyter_nbextensions_configurator
RUN pip install jupyter_contrib_nbextensions

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
  
WORKDIR /home/jovyan
RUN echo "source('http://bioconductor.org/biocLite.R'); biocLite('plotly')" | R --vanilla

ADD . /home/jovyan
