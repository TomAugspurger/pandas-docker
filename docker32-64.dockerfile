FROM ubuntu:latest
RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y wget libc6:i386 libncurses5:i386 #  libstdc++6:i386 && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /root
RUN  wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86.sh && sh Miniconda3-latest-Linux-x86.sh -b
ENV PATH="/root/miniconda3/bin:${PATH}"
RUN conda update -y conda
COPY pandas /pandas
RUN conda env create -q --file=/pandas/ci/deps/azure-36-32bit.yaml

ENV CONDA_BUILD=1
WORKDIR /pandas
COPY conda_activate /conda_activate
RUN echo ". /root/miniconda3/etc/profile.d/conda.sh" >> /root/.bashrc
RUN /conda_activate
