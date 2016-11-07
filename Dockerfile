FROM debian
MAINTAINER diogo.fe.costa@gmail.com

RUN apt-get update && apt-get install -y sudo build-essential libssl-dev libreadline6-dev curl git libffi-dev git-core libpq-dev redis-server --fix-missing

COPY install-rbenv.sh /usr/sbin/

RUN chmod 755 /usr/sbin/install-rbenv.sh

RUN useradd -m -d /home/ruby -p ruby ruby && adduser ruby sudo && chsh -s /bin/bash ruby

RUN /usr/sbin/install-rbenv.sh

USER ruby
ENV HOME /home/ruby
ENV PATH /home/ruby/.rbenv/shims:/home/ruby/.rbenv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

#RUN cd /home/ruby && git clone https://github.com/muratso/uptime_checker.git uptime_checker
COPY yousebots-guide /home/ruby/yousebots-guide

RUN cd /home/ruby/yousebots-guide && bundle update && bundle install

ENTRYPOINT ["cucumber","/home/ruby/yousebots-guide/features/"]

# Creating variables to be received "Ex: --center"
CMD ["$1"]
