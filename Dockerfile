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
RUN sudo apt-get install  wget build-essential chrpath libssl-dev libxft-dev -y
RUN sudo apt-get install libfreetype6 libfreetype6-dev -y
RUN sudo apt-get install libfontconfig1 libfontconfig1-dev -y
RUN wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2
RUN sudo tar xvjf phantomjs-2.1.1-linux-x86_64.tar.bz2
RUN sudo mv phantomjs-2.1.1-linux-x86_64 /usr/local/share
RUN sudo ln -sf /usr/local/share/phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/local/bin

COPY yousebots-guide /opt/yousebots-guide
RUN chown ruby:ruby /opt/yousebots-guide/*
RUN chmod 755 /opt/yousebots-guide/*
USER ruby
RUN cd /opt/yousebots-guide && bundle

VOLUME ["/automated"]
WORKDIR /automated
ENTRYPOINT ["cucumber"]