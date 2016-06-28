FROM ubuntu:14.04
MAINTAINER Marica Antonacci <marica.antonacci@gmail.com>
LABEL description="Container image to run AmberTools v15"

RUN apt-get update -y
RUN apt-get install software-properties-common -y
RUN apt-add-repository ppa:ansible/ansible
RUN apt-get update && \
    apt-get install -y \
        ansible 

ENV AMBERHOME /usr/local/amber14
ENV PATH $PATH:/usr/lib64/openmpi/bin/:$AMBERHOME/bin
ENV LD_LIBRARY_PATH $AMBERHOME/lib
RUN ansible-galaxy install indigo-dc.ambertools && \
    ansible-galaxy install indigo-dc.oneclient && \
    ansible-playbook /etc/ansible/roles/indigo-dc.ambertools/tests/ambertools.yml && \
    ansible-playbook /etc/ansible/roles/indigo-dc.oneclient/tests/test.yml

#RUN wget --no-check-certificate -q -O - https://get.onedata.org/oneclient.sh | bash
#RUN apt-get install --only-upgrade libtbb2

RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV AUTHENTICATION=token
ENV NO_CHECK_CERTIFICATE=true
