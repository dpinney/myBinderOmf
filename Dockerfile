# Base system stuff
FROM ubuntu:16.04
RUN apt-get -y update && apt-get install -y python sudo curl git
RUN curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py" && python get-pip.py
RUN pip install --upgrade pip && \
    pip install --no-cache notebook

# default user stuff for mybinder.org
ARG NB_USER
ARG NB_UID
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}
RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}
WORKDIR ${HOME}
USER ${USER}

# hack to get matplotlib working
RUN pip install --user matplotlib==2.1.2

# move stuff so it's in the homedir
COPY main.ipynb ${HOME}
COPY README.md ${HOME}

# Grab OMF
USER root
RUN cd ${HOME}
RUN git clone https://github.com/dpinney/omf.git
RUN cd omf && python install.py
