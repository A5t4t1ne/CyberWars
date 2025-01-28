FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y \
    openssh-server \
    vim \
    sudo \
    curl \
	cron \
    unzip \
	netcat-openbsd \
	ca-certificates

# install docker
RUN install -m 0755 -d /etc/apt/keyrings
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
RUN chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
RUN echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN apt-get update

RUN apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# sshd configurations
COPY sshd_config /etc/ssh/sshd_config
RUN mkdir /var/run/sshd


# run user-creation and home-directory management script
COPY initial_home_contents /home
COPY create_users.sh create_users.sh
RUN chmod +x create_users.sh && ./create_users.sh  && rm create_users.sh


# Add required files
COPY superSecret.txt /tmp/superSecret.txt
COPY hosts /etc/hosts
COPY sudoers /etc/sudoers

# cronjob
COPY get_to_root_cron.txt /etc/cron.d/getHarmlessFile
RUN chmod 644 /etc/cron.d/getHarmlessFile
RUN chown root:root /etc/cron.d/getHarmlessFile
RUN crontab /etc/cron.d/getHarmlessFile

# root settings
RUN echo "1_4m_th3_r00t_0f_4ll_3v1l" > /root/flag.txt
RUN echo "root:very_long_passwd_lol_4321"  | chpasswd
# RUN echo 'root:root' | chpasswd

EXPOSE 22

COPY start.sh /start.sh
RUN chmod +x /start.sh
CMD ["/start.sh"]
