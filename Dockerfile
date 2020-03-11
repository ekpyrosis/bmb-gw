FROM ubuntu:bionic
#RUN apt-get update && echo "deb http://download.rethinkdb.com/apt `lsb_release -cs` main" > /etc/apt/sources.list.d/rethinkdb.list && apt-get install -y wget && wget -O- http://download.rethinkdb.com/apt/pubkey.gpg | apt-key add - && apt-get update && apt-get install -y rethinkdb python-pip && rm -rf /var/lib/apt/lists/*
#RUN \
#  echo "deb http://download.rethinkdb.com/apt `lsb_release -cs` main" > /etc/apt/sources.list.d/rethinkdb.list && \
#  wget -O- http://download.rethinkdb.com/apt/pubkey.gpg | apt-key add - && \
#  apt-get update && \
#  apt-get install -y rethinkdb python-pip && \
#  rm -rf /var/lib/apt/lists/*

RUN apt-get -qqy update \
    && apt-get install -y --no-install-recommends ca-certificates gnupg2 \
    && rm -rf /var/lib/apt/lists/*

RUN apt-key adv --keyserver keys.gnupg.net --recv-keys "539A 3A8C 6692 E6E3 F69B 3FE8 1D85 E93F 801B B43F" \
    && echo "deb https://download.rethinkdb.com/apt bionic main" > /etc/apt/sources.list.d/rethinkdb.list

ENV RETHINKDB_PACKAGE_VERSION 2.4.0~0bionic

RUN apt-get -qqy update \
	&& apt-get install -y rethinkdb=$RETHINKDB_PACKAGE_VERSION \
	&& rm -rf /var/lib/apt/lists/*

# Install python driver for rethinkdb
RUN pip install rethinkdb
VOLUME ["/data"]
WORKDIR /data
CMD ["rethinkdb", "--bind", "all"]
EXPOSE 8080
EXPOSE 28015
EXPOSE 29015

#FROM python:3
WORKDIR /
COPY . /app
WORKDIR /app
#RUN pip install -r requirements.txt
RUN pip3 install https://github.com/squeaky-pl/japronto/archive/master.zip
#RUN pip install rethinkdb
EXPOSE 262
CMD python ./main.py