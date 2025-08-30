# Dockerfile References
- **Dockerfile:** 
    - https://github.com/confluentinc/cp-all-in-one/blob/7.9.0-post/cp-all-in-one-cloud/Dockerfile-connect
    - https://github.com/confluentinc/cp-all-in-one/blob/7.9.0-post/cp-all-in-one-cloud/docker-compose.connect.yml
- **Connector Config:** https://docs.confluent.io/platform/current/installation/docker/config-reference.html#kconnect-long-configuration

# KSQL-CLI
- To open ksqlDB CLI session connected to ksqlDB server, run:
```sh
docker exec -it ksqldb-cli ksql --config-file /etc/ksqldb-cli.properties http://ksqldb-server:8088
docker exec -it ksqldb-cli ksql --config-file /etc/ksqldb-cli.properties http://ksqldb-server:8088 -e "SHOW STREAMS;"
```

