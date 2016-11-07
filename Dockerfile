FROM debian
MAINTAINER diogo.fe.costa@gmail.com

RUN apt-get update && apt-get install -y sudo build-essential libssl-dev libreadline6-dev curl git libffi-dev git-core libpq-dev redis-server --fix-missing

ADD install-rbenv.sh /usr/sbin/

RUN chmod 755 /usr/sbin/install-rbenv.sh

RUN /usr/sbin/install-rbenv.sh

RUN ruby -v