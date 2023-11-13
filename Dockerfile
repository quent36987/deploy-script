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
    pip3 install ansible-core; \
    pip3 install docker; \
    pip3 install docker-compose;

#install git
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    git \
    && rm -rf /var/lib/apt/lists/*


COPY requirements.yml .

RUN ansible-galaxy install -r requirements.yml

WORKDIR /ansible

CMD ["tail", "-f", "/dev/null"]
