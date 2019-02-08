FROM ubuntu:cosmic
LABEL maintainer="pey.mortazavi@gmail.com"
RUN apt-get update
RUN apt-get install --assume-yes g++ python3-pip cmake openssh-server gdb make rsync

# Add user 'tools' and setup SSH.
ADD docker-entrypoint.sh /usr/local/bin
RUN /usr/local/bin/docker-entrypoint.sh
RUN adduser tools
RUN echo "tools:tools" | chpasswd
EXPOSE 22

# Use docker-bash-rc file to set up bash and make it pretty.
ADD docker-etc-profile.sh /etc/docker-etc-profile.sh
RUN chmod 777 /etc/docker-etc-profile.sh
RUN echo "source /etc/docker-etc-profile.sh" >> /home/tools/.bashrc

# Setup locale.
RUN apt-get install locales locales-all
ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8

CMD /usr/sbin/sshd -D
