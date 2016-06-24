FROM ubuntu:14.04
MAINTAINER Marica Antonacci <marica.antonacci@gmail.com>
LABEL description="Container image to run AmberTools v15"

ENV AMBERHOME /usr/local/amber14
ENV PATH $PATH:/usr/lib64/openmpi/bin/:$AMBERHOME/bin
ENV LD_LIBRARY_PATH $AMBERHOME/lib
RUN ansible-galaxy install indigo-dc.ambertools && \
    ansible-playbook /etc/ansible/roles/indigo-dc.ambertools/tests/ambertools.yml

RUN wget --no-check-certificate -q -O - https://get.onedata.org/oneclient.sh | bash
RUN apt-get install --only-upgrade libtbb2

ENV AUTHENTICATION=token
ENV NO_CHECK_CERTIFICATE=true
