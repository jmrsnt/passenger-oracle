FROM phusion/passenger-full

ENV HOME /root
ENV LD_LIBRARY_PATH /usr/lib/oracle/12.2/client64/lib

# Install Oracle Instant Client

COPY ./lib/oracle-instantclient12.2-devel-12.2.0.1.0-1.x86_64.rpm /tmp/oracle-instantclient12.2-devel-12.2.0.1.0-1.x86_64.rpm
COPY ./lib/oracle-instantclient12.2-basic-12.2.0.1.0-1.x86_64.rpm /tmp/oracle-instantclient12.2-basic-12.2.0.1.0-1.x86_64.rpm

RUN bash -lc 'echo "export LD_LIBRARY_PATH=/usr/lib/oracle/12.2/client64/lib:$LD_LIBRARY_PATH" >> /etc/container_environment.sh'
RUN bash -lc 'add-apt-repository universe'
RUN bash -lc 'echo "deb http://cz.archive.ubuntu.com/ubuntu bionic main" >> /etc/apt/sources.list'
RUN bash -lc 'echo "deb http://cz.archive.ubuntu.com/ubuntu bionic-security main" >> /etc/apt/sources.list'

RUN bash -lc 'apt-get update; apt update'
RUN bash -lc 'apt-get install -y alien libaio-dev gettext-base nano'

RUN bash -lc 'alien -i /tmp/oracle-instantclient12.2-basic-12.2.0.1.0-1.x86_64.rpm'
RUN bash -lc 'alien -i /tmp/oracle-instantclient12.2-devel-12.2.0.1.0-1.x86_64.rpm'

RUN bash -lc 'mkdir -p /usr/include/sys && ln -s /usr/include/linux/types.h /usr/include/sys/types.h'

RUN ln /usr/lib/oracle/12.2/client64/lib/libclntsh.so /usr/lib/oracle/12.2/client64/lib/libclntsh.so.10.1

RUN apt-get -y autoremove
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*