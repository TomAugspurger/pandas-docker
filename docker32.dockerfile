FROM clinstid/i386-python

RUN apt-get update && apt-get install -y build-essential curl bzip2
RUN curl -O https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86.sh
RUN sh Miniconda3-latest-Linux-x86.sh -b

ENV PATH="~/miniconda3/bin:${PATH}"
RUN ~/miniconda3/bin/conda create -n pandas python=3.6 pytest numpy cython pytz python-dateutil nomkl
RUN echo "source activate pandas" > ~/.bashrc
ENV PATH="~/miniconda3/envs/pandas/bin:${PATH}"

COPY pandas /pandas
RUN cd /pandas && ~/miniconda3/envs/pandas/bin/python setup.py build_ext -i && \
    ~/miniconda3/envs/pandas/bin/python -m pip install -e .
