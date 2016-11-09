FROM debian
MAINTAINER diogo.fe.costa@gmail.com

RUN apt-get update && apt-get install -y sudo build-essential libssl-dev libreadline6-dev curl git libffi-dev git-core libpq-dev redis-server --fix-missing

COPY install-rbenv.sh /usr/sbin/

RUN chmod 755 /usr/sbin/install-rbenv.sh

RUN useradd -m -d /home/ruby -p ruby ruby && adduser ruby sudo && chsh -s /bin/bash ruby

RUN /usr/sbin/install-rbenv.sh

ENV HOME /home/ruby
ENV PATH /home/ruby/.rbenv/shims:/home/ruby/.rbenv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

#RUN cd /home/ruby && git clone https://github.com/muratso/uptime_checker.git uptime_checker
COPY /var/www/yousebots-guide /opt/yousebots-guide
RUN chown ruby:ruby /opt/yousebots-guide/*
RUN chmod 755 /opt/yousebots-guide/*
USER ruby
RUN cd /opt/yousebots-guide && bundle update
RUN cd /opt/yousebots-guide && bundle install

ENTRYPOINT ["cucumber","/opt/yousebots-guide/features/"]
CMD [""]