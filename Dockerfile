FROM debian
MAINTAINER diogo.fe.costa@gmail.com

# Atualizando ambiente
RUN apt-get update && apt-get install -y sudo build-essential chrpath libssl-dev libxft-dev libfontconfig libreadline6-dev curl git libffi-dev git-core libpq-dev redis-server --fix-missing

# Instalando o Ruby
COPY install-rbenv.sh /usr/sbin/
RUN chmod 755 /usr/sbin/install-rbenv.sh
RUN useradd -m -d /home/ruby -p ruby ruby && adduser ruby sudo && chsh -s /bin/bash ruby
RUN /usr/sbin/install-rbenv.sh
ENV HOME /home/ruby
ENV PATH /home/ruby/.rbenv/shims:/home/ruby/.rbenv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

## Instalando o PhantomJS
COPY install-phantomjs.sh /usr/sbin/
RUN chmod 755 /usr/sbin/install-phantomjs.sh
RUN /usr/sbin/install-phantomjs.sh

#RUN cd /home/ruby && git clone https://github.com/muratso/uptime_checker.git uptime_checker
COPY yousebots-guide /opt/yousebots-guide
RUN chown ruby:ruby /opt/yousebots-guide/*
RUN chmod 755 /opt/yousebots-guide/*
USER ruby
RUN cd /opt/yousebots-guide && bundle

VOLUME ["/automated"]
WORKDIR /automated
ENTRYPOINT ["cucumber"]
#CMD ["features/contact_features"]