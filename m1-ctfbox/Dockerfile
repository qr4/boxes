# Docker image to use with Vagrant
# Aims to be as similar to normal Vagrant usage as possible

FROM --platform=linux/x86-64 archlinux/archlinux
ENV container docker

RUN pacman -Syu --noconfirm zsh tmux vim sudo openssh python3


# Add sshd server so we can 'vagrant ssh' later
RUN mkdir /var/run/sshd
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ''
RUN useradd --create-home -s /bin/bash vagrant
RUN echo -e "vagrant\nvagrant" | (passwd vagrant)
RUN echo 'vagrant ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/vagrant
RUN chmod 440 /etc/sudoers.d/vagrant
RUN mkdir -p /home/vagrant/.ssh
RUN chmod 700 /home/vagrant/.ssh
ADD https://raw.githubusercontent.com/hashicorp/vagrant/master/keys/vagrant.pub /home/vagrant/.ssh/authorized_keys
RUN chmod 600 /home/vagrant/.ssh/authorized_keys
RUN chown -R vagrant:vagrant /home/vagrant/.ssh

# Allow public key authentication for 'vagrant ssh'
RUN sed -i 's/^#PubkeyAuthentication yes/PubkeyAuthentication yes/i' /etc/ssh/sshd_config
# As the container isn't normally running systemd, /run/nologin needs to be removed to allow SSH
RUN rm -rf /run/nologin

# Start sshd
RUN systemctl enable sshd
EXPOSE 22

# Install the replacement systemctl command
ADD https://raw.githubusercontent.com/gdraheim/docker-systemctl-replacement/master/files/docker/systemctl3.py /usr/bin/systemctl
RUN chmod 755 /usr/bin/systemctl

CMD /usr/bin/systemctl
