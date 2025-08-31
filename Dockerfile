# base image
FROM confluentinc/cp-server-connect-base:7.9.0

# worker dir, user
WORKDIR /connect/tools
USER root

# copy file
COPY . /connect

# install dependencies
RUN yum update -y && \
    yum install -y curl jq vim ncurses unzip && \
    yum clean all && \
    rm -rf /var/cache/yum

# terminal settings
RUN echo 'export PS1="\[$(tput bold)\]\[$(tput setaf 6)\]\\t \\d\\n\[$(tput setaf 2)\][\[$(tput setaf 3)\]\u\[$(tput setaf 1)\]@\[$(tput setaf 3)\]\h \[$(tput setaf 6)\]\w\[$(tput setaf 2)\]]\[$(tput setaf 4)\\]\\$ \[$(tput sgr0)\]"' >> /root/.bashrc \
    && echo "alias grep='grep --color=auto'" >> /root/.bashrc

# timezone
RUN ln -snf /usr/share/zoneinfo/Asia/Kuala_Lumpur /etc/localtime && \
    echo Asia/Kuala_Lumpur > /etc/timezone

# install plugins
RUN confluent-hub install --no-prompt debezium/debezium-connector-mysql:2.2.1 && \
    confluent-hub install --no-prompt confluentinc/kafka-connect-jdbc:10.7.4 && \
    confluent-hub install --no-prompt confluentinc/connect-transforms:1.4.5 
RUN confluent-hub install --no-prompt iceberg/iceberg-kafka-connect:1.9.1 && \
    wget -P /usr/share/confluent-hub-components/iceberg-iceberg-kafka-connect/lib/ https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-api/1.9.1/iceberg-api-1.9.1.jar && \
    wget -P /usr/share/confluent-hub-components/iceberg-iceberg-kafka-connect/lib/ https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-core/1.9.1/iceberg-core-1.9.1.jar && \
    wget -P /usr/share/confluent-hub-components/iceberg-iceberg-kafka-connect/lib/ https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-common/1.9.1/iceberg-common-1.9.1.jar && \
    wget -P /usr/share/confluent-hub-components/iceberg-iceberg-kafka-connect/lib/ https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-bundled-guava/1.9.1/iceberg-bundled-guava-1.9.1.jar
    
# install python packages
RUN pip3 install --upgrade pip && \
    pip3 install -r /connect/requirements.txt