# Utiliser une image de base Python slim pour un conteneur léger
#FROM python:3.9.18-slim-bullseye
#
## Installer les dépendances nécessaires
#RUN apt-get update && \
#    apt-get install -y --no-install-recommends \
#    apt-utils \
#    gcc \
#    libffi-dev \
#    libssl-dev \
#    libkrb5-dev \
#    curl \
#    ssh \
#    && rm -rf /var/lib/apt/lists/*
#
## Installer Ansible via pip
#RUN pip3 install --no-cache-dir --upgrade pip cffi && \
#    pip3 install --no-cache-dir ansible pywinrm[kerberos]
#
## Installer Docker CLI pour interagir avec le daemon Docker de l'hôte
#RUN curl -fsSL https://get.docker.com -o get-docker.sh && \
#    sh get-docker.sh && \
#    rm get-docker.sh



#FROM python:3.9-slim-bullseye
#
#RUN apt-get update && \
#    apt-get install -y --no-install-recommends
#
#RUN pip3 install --upgrade pip; \
#    pip3 install --upgrade virtualenv; \
#    pip3 install pywinrm[kerberos]; \
#    pip3 install pywinrm; \
#    pip3 install jmspath; \
#    pip3 install requests; \
#    python3 -m pip install ansible; \
#    pip3 install ansible-core;

FROM ubuntu:20.04

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    python3-setuptools \
    python3-wheel \
    python3-dev \
    libffi-dev \
    libssl-dev \
    libkrb5-dev \
    curl \
    ssh \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install --upgrade pip; \
    pip3 install --upgrade virtualenv; \
    pip3 install pywinrm[kerberos]; \
    pip3 install pywinrm; \
    pip3 install jmspath; \
    pip3 install requests; \
    pip3 install ansible; \
    pip3 install ansible-core;

#install git
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    git \
    && rm -rf /var/lib/apt/lists/*


# installer Docker CLI pour interagir avec le daemon Docker de l'hôte
#RUN curl -fsSL https://get.docker.com -o get-docker.sh && \
#    sh get-docker.sh && \
#    rm get-docker.sh

RUN pip3 install docker
RUN pip3 install docker-compose


COPY requirements.yml .

RUN ansible-galaxy install -r requirements.yml

WORKDIR /ansible

CMD ["tail", "-f", "/dev/null"]
# Exécuter le playbook Ansible en utilisant l'inventaire par défaut
#CMD ["ansible-playbook", "-i", "localhost/hosts", "playbook.yml", "--vault-password-file", "pass"]

