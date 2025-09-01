# base image
FROM confluentinc/cp-server-connect-base:8.0.0

# worker dir, user
WORKDIR /connect/tools
USER root

# copy file
COPY . /connect

# install dependencies
RUN yum update -y && \
    yum install --allowerasing -y curl jq vim ncurses unzip && \
    yum clean all && \
    rm -rf /var/cache/yum

# terminal settings
RUN echo 'export PS1="\[$(tput bold)\]\[$(tput setaf 6)\]\\t \\d\\n\[$(tput setaf 2)\][\[$(tput setaf 3)\]\u\[$(tput setaf 1)\]@\[$(tput setaf 3)\]\h \[$(tput setaf 6)\]\w\[$(tput setaf 2)\]]\[$(tput setaf 4)\\]\\$ \[$(tput sgr0)\]"' >> /root/.bashrc \
    && echo "alias grep='grep --color=auto'" >> /root/.bashrc

# timezone
RUN ln -snf /usr/share/zoneinfo/Asia/Kuala_Lumpur /etc/localtime && \
    echo Asia/Kuala_Lumpur > /etc/timezone

# install connector plugins
RUN confluent-hub install --no-prompt debezium/debezium-connector-mysql:3.1.2 && \
    confluent-hub install --no-prompt confluentinc/connect-transforms:1.4.5

# install sink-iceberg-connector
RUN unzip -o /connect/plugins/iceberg-kafka-connect-runtime-hive-1.11.0-SNAPSHOT.zip -d /usr/share/confluent-hub-components/

# install python packages
RUN pip3 install --upgrade pip && \
    pip3 install -r /connect/requirements.txt

