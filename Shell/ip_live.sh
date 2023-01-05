erver:
  port: 8081
spring:
  jackson:
    date-format: yyyy-MM-dd HH:mm:ss
    time-zone: GMT+8
    default-property-inclusion: non_null

canal.conf:
  mode: tcp # kafka rocketMQ
  canalServerHost: canal-server:11111
#  zookeeperHosts: slave1:2181
#  mqServers: 127.0.0.1:9092 #or rocketmq
#  flatMessage: true
  batchSize: 500
  syncBatchSize: 1000
  retries: 0
  timeout:
  accessKey:
  secretKey:
  srcDataSources:
    defaultDS:
      url: jdbc:mysql://${src_mysql_host:mysql}:3306/${src_db_name:db_one_travel}?useUnicode=true
      username: ${src_mysql_username:root}
      password: ${src_mysql_password:Xnh00<>?}
    defaultDS2:
      url: jdbc:mysql://${src_mysql_host:mysql}:3306/db_dist?useUnicode=true
      username: ${src_mysql_username:root}
      password: ${src_mysql_password:Xnh00<>?}
  canalAdapters:
  - instance: example # canal instance Name or mq topic name
    groups:
    - groupId: g1
      outerAdapters:
      - name: logger
      - name: es
        hosts: ${des_es_host:elasticsearch}:9300
        properties:
          cluster.name: docker-cluster
  - instance: mysql
    groups:
    - groupId: g1
      outerAdapters:
      - name: logger
      - name: rdb
        key: myssql1
        properties:
          jdbc.driverClassName: com.mysql.jdbc.Driver
          jdbc.url: jdbc:mysql://${src_mysql_host:mysql}:3306/db_hotel?useUnicode=true
          jdbc.username: ${src_mysql_username:root}
          jdbc.password: ${src_mysql_password:Xnh00<>?}