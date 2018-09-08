FROM jupyter/notebook

MAINTAINER Abeer Almutairy

# Installing libraries dependencies
RUN apt-get update && apt-get install -y --no-install-recommends python-numpy python3-numpy libpng3 libfreetype6-dev libatlas-base-dev gfortran libgdal1-dev libjpeg-dev sasl2-bin libsasl2-2 libsasl2-dev libsasl2-modules unixodbc-dev python3-tk && apt-get clean && rm -rf /var/lib/apt/lists/* 

# Install python3 libraries
RUN pip3 --no-cache-dir install ipywidgets \
								pandas \
								numpy \
								matplotlib \
								scipy \
								scikit-learn \
								pyodbc \
								impyla \
								hdfs \
								hdfs[avro,dataframe,kerberos] \
								scikit-image \
								bokeh \
								keras \
								pybrain \
								statsmodels \
								mpld3 \
								networkx \
								fiona \
								folium \
								shapely \
								thrift_sasl \
								sasl \
								SQLAlchemy \
								ibis-framework \
								pymongo \
								seaborn \
								&& rm -rf /root/.cache

# Install python2 libraries
RUN pip --no-cache-dir install ipywidgets \
								pandas \
								numpy \
								matplotlib \
								scipy \
								scikit-learn \
								pyodbc \
								impyla \
								bokeh \
								scikit-image \
								pybrain \
								networkx \
								&& rm -rf /root/.cachex
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

#RUN conda install jupyter_contrib_nbextensions
#RUN conda install -c conda-forge jupyter_contrib_nbextensions
RUN pip install jupyter_contrib_nbextensions

RUN conda install -c conda-forge jupyter_nbextensions_configurator
#RUN pip install jupyter_nbextensions_configurator
RUN jupyter nbextensions_configurator enable --user


# Run the notebook
CMD jupyter notebook \
    --ip=* \
    --MappingKernelManager.time_to_dead=10 \
    --MappingKernelManager.first_beat=3 \
    --notebook-dir=/notebooks-dir/
    
