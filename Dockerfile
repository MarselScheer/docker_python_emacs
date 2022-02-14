FROM tensorflow/tensorflow:2.7.0-gpu

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Berlin


RUN apt-get update && apt-get install -y \
    software-properties-common \
    && apt-get install -y \
    wget \
    ranger \
    git \
    tig \
    htop \
    python3-venv \
    python3-pip \
    # emacs-libs
    wget libsm-dev libjansson4 libncurses5 libgccjit0 \
    librsvg2-2 libjpeg9 libtiff5 libgif7 libpng16-16 \
    libgtk-3-0 libharfbuzz0b libxpm4 \
    && wget https://github.com/emacs-ng/emacs-ng/releases/download/v0.0.a89eb3a/emacs-ng_0.0.a89eb3a_amd64.deb \
    && dpkg -i emacs-ng_0.0.a89eb3a_amd64.deb \
    && ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime \
    && ln -s /usr/bin/python3 /usr/bin/python \
    && pip3 install pyright

RUN wget https://dvc.org/deb/dvc.list -O /etc/apt/sources.list.d/dvc.list \
    && wget -qO - https://dvc.org/deb/iterative.asc | apt-key add - \
    && apt update \
    && apt install dvc

RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add - \
    && apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main" \
    && apt-get update && apt-get install -y terraform

RUN useradd -m m
USER m
WORKDIR /home/m
ENV DISPLAY=:0
ENV PYTHONPATH=./src
ENV KAGGLE=False
RUN mkdir -p /tmp/hostfs \
    && ln -s /tmp/hostfs \
    && ln -s /tmp/hostfs/.emacs.d \
    && ln -s /tmp/hostfs/.gitconfig \
    && ln -s /tmp/hostfs/.ssh 

CMD /bin/bash
