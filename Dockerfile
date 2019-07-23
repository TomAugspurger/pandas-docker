FROM continuumio/miniconda3:latest
ARG dep_file

RUN apt-get update && apt-get install -y build-essential

COPY pandas /pandas
RUN conda env create -f pandas/ci/deps/$dep_file
WORKDIR /pandas

RUN /bin/bash -c "source activate pandas-dev && python setup.py build_ext -i && python -m pip install -e ."
