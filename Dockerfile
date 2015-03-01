# Build:
#   docker build -t gbevan/vagrant-centos-dev:latest .
#
# Run:
#  vagrant up --provider=docker
#
# resolve dns issues:
# /etc/conf/docker
#  DOCKER_OPTS="--dns ip_1 --dns ip_2"
#

FROM centos:latest
MAINTAINER Graham Bevan "graham.bevan@ntlworld.com"

ENV DEBIAN_FRONTEND noninteractive
ENV LANG=C
ENV LC_ALL=C

RUN yum -y update && \
    yum -y upgrade && \
    yum -y groupinstall "Development Tools" && \
    yum -y install libpcap postgresql postgresql-server postgresql-libs libdbi libdbi-dbd-pgsql perl-DBI perl-DBD-Pg httpd php php-pgsql php-gd sysstat && \
    yum -y install initscripts rsyslog sudo zip tar redhat-lsb-core openssh-clients wget curl openssh-server unzip vim-enhanced && \
    echo "NETWORKING=yes" > /etc/sysconfig/network && \
    sed -i -e '/pam_loginuid\.so/ d' /etc/pam.d/sshd && \
    echo " " > /sbin/start_udev && \
    sed -i 's/.*requiretty$/Defaults !requiretty/' /etc/sudoers && \
    groupadd vagrant && \
    useradd vagrant -g vagrant -G wheel && \
    echo "vagrant:vagrant" | chpasswd && \
    echo "vagrant        ALL=(ALL)       NOPASSWD: ALL" > /etc/sudoers.d/vagrant && \
    chmod 0440 /etc/sudoers.d/vagrant && \
    mkdir -p /home/vagrant/.ssh && \
    echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key" > /home/vagrant/.ssh/authorized_keys && \
    chown -R vagrant: /home/vagrant/.ssh && \
    echo "set modeline" >> /etc/vimrc && \
    echo "export TERM=vt100\nexport LANG=C\nexport LC_ALL=C" > /etc/profile.d/dockenv.sh && \
    rm -rf /tmp/* /var/tmp/*; \
    yum clean all

CMD ["/usr/sbin/sshd", "-D", "-e"]
EXPOSE 22
