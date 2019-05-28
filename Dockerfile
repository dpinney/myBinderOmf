FROM ubuntu:16.04
# install the notebook package
RUN apt-get -y update && apt-get install -y python sudo
RUN pip install --upgrade pip && \
    pip install --no-cache notebook

# create user with a home directory
ARG NB_USER
ARG NB_UID
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}

# other default user stuff for mybinder.org
RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}
WORKDIR ${HOME}
USER ${USER}

# move stuff
COPY main.ipynb ${HOME}
COPY README.md ${HOME}