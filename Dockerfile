FROM ubuntu:15.10
MAINTAINER Marica Antonacci <marica.antonacci@gmail.com>
LABEL description="Container image to run AmberTools v15"

RUN locale-gen en_US.UTF-8 && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        csh \
        cython \
        flex \
        g++ \
        gfortran \
        libbz2-dev \
        libfreetype6-dev \
        liblapack-dev \
        libatlas-dev \
        libopenmpi-dev \
        openmpi-bin \
        openmpi-common \
        patch  \
        python-dev \
        python-matplotlib \
        python-pip \
        python-tk \
        tar \
        time \
        wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    pip install --upgrade pip && \
    pip install mako && \
    pip install numpy && \
    pip install scipy

ENV AMBERHOME=/usr/local/amber14
ENV PATH=$PATH:/usr/lib64/openmpi/bin/:$AMBERHOME/bin
ENV LD_LIBRARY_PATH=$AMBERHOME/lib

RUN cd /usr/local && \
    wget http://www.lip.pt/~david/AmberTools15_indigo.tgz && \
    tar zxvf AmberTools15_indigo.tgz && \
    rm -f AmberTools15_indigo.tgz && \
    cd $AMBERHOME && ./configure -noX11 gnu && make install  && \
    cd $AMBERHOME && ./configure -mpi -noX11 gnu && make install && \
    rm -rf $AMBERHOME/AmberTools/src
