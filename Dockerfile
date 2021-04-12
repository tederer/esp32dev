FROM ubuntu:18.04

SHELL ["/bin/bash", "-c"]

RUN apt-get update --quiet

RUN apt-get install --quiet --assume-yes git wget flex bison gperf python python-pip python-setuptools cmake ninja-build ccache libffi-dev  libssl-dev dfu-util libncurses-dev
RUN apt-get install --quiet --assume-yes python3 python3-pip python3-setuptools 
RUN apt-get install --quiet --assume-yes vim

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 10

RUN cd && mkdir esp && cd esp && git clone --recurse-submodules https://github.com/espressif/esp-idf.git
RUN cd ~/esp/esp-idf && git checkout release/v4.2
RUN cd ~/esp/esp-idf && git submodule update --init --recursive
RUN cd ~/esp/esp-idf && ./install.sh

ENTRYPOINT source ~/esp/esp-idf/export.sh && if [ "$PROJECT_ROOT" != "" ]; then cd $PROJECT_ROOT; fi && /bin/bash
