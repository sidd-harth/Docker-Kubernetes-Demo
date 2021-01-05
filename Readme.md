# Spring Boot, MySQL, JPA, Hibernate Rest API Tutorial

Build Restful CRUD API for a simple Note-Taking application using Spring Boot, Mysql, JPA and Hibernate.

## Requirements

1. Java - 1.8.x

2. Maven - 3.x.x

3. Mysql - 5.x.x

## Steps to Setup

**1. Credits**
```bash
callicoder
```

**2. Create Mysql database**
```bash
create database employees
```

**3. Change mysql username and password as per your installation**

+ open `src/main/resources/application.properties`

+ change `spring.datasource.username` and `spring.datasource.password` as per your mysql installation

**2. Build the app using maven**

```bash
mvn clean package
```

Alternatively, you can run the app without packaging it using -

```bash
mvn spring-boot:run
```

The app will start running at <http://localhost:8080>.

## Explore Rest APIs

The app defines following CRUD APIs.

    GET /api/employees
    
    POST /api/employees
    
    GET /api/employees/{employeesId}
    
    PUT /api/employees/{employeesId}
    
    DELETE /api/employees/{employeesId}

You can test them using postman or any other rest client.

## Docker Images for K8S Demo
### Hardcoded Values
```
spring.datasource.url = jdbc:mysql://mysql-service:3306/hclDatabase?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8&allowMultiQueries=true&useSSL=false
spring.datasource.username = hclUser
spring.datasource.password = hclPassword
spring.datasource.platform = mysql
spring.datasource.initialization-mode = always
```
```
siddharth67/springboot-mysql:hardcoded
```

### K8S Dynamic Values
```
spring.datasource.url = jdbc:mysql://${KUBE_CONFIG_HOST}:${KUBE_CONFIG_PORT}/${KUBE_CONFIG_DATABASE}?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8&allowMultiQueries=true&useSSL=false
spring.datasource.username = ${KUBE_SECRET_USERNAME}
spring.datasource.password = ${KUBE_SECRET_PASSWORD}
spring.datasource.platform = mysql
spring.datasource.initialization-mode = always
```

```
siddharth67/springboot-mysql:dynamic
```
