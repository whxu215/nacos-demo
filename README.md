### Nacos: A distributed configuration center and register center.

### Nacos download URL: https://github.com/alibaba/nacos/releases/tag/0.9.0

### Steps:
* cd nacos-docker
* docker-compose -f example standalone-mysql.yaml up
* visit http://localhost:8848/nacos
* 配置列表
  ```
  dataId: example-local.properties
  配置内容：
  useLocalCache=true
  server.port=8010
  ```
* run SpringbootApplication
  ```
  -Dspring.profiles.active=local
  ```
* http://localhost:8010/cache