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
COPY create_users.sh create_users.sh
COPY initial_home_contents /home
RUN chmod +x create_users.sh && ./create_users.sh 
RUN rm create_users.sh

# Groot to Drax
RUN mkdir -p /home/common_playground
RUN chmod 1777 /home/common_playground
RUN chown Groot:Groot /home/common_playground/groot_is_learning.py
RUN chmod 764 /home/common_playground/groot_is_learning.py
COPY ./sudoers /etc/sudoers

# cronjob
RUN chmod 744 /home/Rocket/get_the_juice.sh
RUN chown Rocket:Rocket /home/Rocket/get_the_juice.sh
COPY get_the_juice_cron /etc/cron.d/get_the_juice
RUN chmod 644 /etc/cron.d/get_the_juice
RUN crontab /etc/cron.d/get_the_juice
RUN chmod +x /home/Rocket/get_the_juice.sh

# root settings
RUN echo "1_4m_th3_r00t_0f_4ll_3v1l" > /root/flag.txt
RUN echo "root:very_long_passwd_lol_4321"  | chpasswd
RUN mkdir /tmp/mimimi
RUN chmod 750 /tmp/mimimi
# RUN echo 'root:root' | chpasswd

EXPOSE 22

COPY start.sh /start.sh
RUN chmod +x /start.sh
CMD ["/start.sh"]
