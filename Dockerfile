FROM debian
MAINTAINER diogo.fe.costa@gmail.com

# Atualizando ambiente
RUN apt-get update && apt-get install -y sudo build-essential wget chrpath libssl-dev libxft-dev libfontconfig libreadline6-dev curl git libffi-dev git-core libpq-dev redis-server --fix-missing
RUN apt-get install libfreetype6 libfreetype6-dev
RUN apt-get install libfontconfig1 libfontconfig1-dev

# Instalando o Phantomjs
RUN export PHANTOM_JS="phantomjs-1.9.8-linux-x86_64"
RUN wget https://bitbucket.org/ariya/phantomjs/downloads/$PHANTOM_JS.tar.bz2
RUN tar xvjf $PHANTOM_JS.tar.bz2
RUN mv $PHANTOM_JS /usr/local/share
RUN ln -sf /usr/local/share/$PHANTOM_JS/bin/phantomjs /usr/local/bin

# Instalando o Ruby
COPY install-rbenv.sh /usr/sbin/
RUN chmod 755 /usr/sbin/install-rbenv.sh
RUN useradd -m -d /home/ruby -p ruby ruby && adduser ruby sudo && chsh -s /bin/bash ruby
RUN /usr/sbin/install-rbenv.sh
ENV HOME /home/ruby
ENV PATH /home/ruby/.rbenv/shims:/home/ruby/.rbenv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

#RUN cd /home/ruby && git clone https://github.com/muratso/uptime_checker.git uptime_checker
COPY yousebots-guide /opt/yousebots-guide
RUN chown ruby:ruby /opt/yousebots-guide/*
RUN chmod 755 /opt/yousebots-guide/*
RUN wget -qO- https://deb.nodesource.com/setup_4.x | bash -
RUN apt-get install -yy nodejs --fix-missing
RUN npm install -g phantomjs
USER ruby
RUN cd /opt/yousebots-guide && bundle
#RUN cd /opt/yousebots-guide && bundle install

VOLUME ["/automated"]
WORKDIR /automated
#ENTRYPOINT ["cucumber"]
#CMD ["features/"]