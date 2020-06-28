FROM jupyter/scipy-notebook

USER root

# Install libraries
RUN apt-get update && apt-get install -y libeigen3-dev libopencv-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/* # clean up

USER jovyan

# Install dev packages
RUN conda install -y -c conda-forge xeus-cling && conda clean --all -f -y

COPY ./cling.ipynb ${HOME}

USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}

EXPOSE 8888
