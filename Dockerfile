FROM ubuntu:cosmic
LABEL maintainer="pey.mortazavi@gmail.com"
RUN apt-get update
RUN apt-get install --assume-yes g++ python3 cmake openssh-server gdb make

# Add user 'tools' and setup SSH.
RUN adduser tools
RUN usermod -aG sudo tools
RUN echo "tools:tools" | chpasswd
ADD docker-entrypoint.sh /usr/local/bin
RUN /usr/local/bin/docker-entrypoint.sh
RUN mkdir /run/sshd
EXPOSE 22

# Setup locale.
RUN apt-get install locales locales-all
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

CMD /usr/sbin/sshd -D