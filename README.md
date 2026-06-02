# Magento Enterprise Docker Setup

## Architecture

Services included:

* PHP 8.4 FPM
* Nginx
* MariaDB 11
* Redis
* OpenSearch 2.12
* RabbitMQ
* MailHog

## Project Structure

magento-enterprise/

├── docker-compose.yml
├── .env.example
├── README.md
├── docker/
├── scripts/
├── src/
└── backups/

## Build Containers

```bash
docker compose build
```

## Start Containers

```bash
docker compose up -d
```

## Verify Containers

```bash
docker ps
```

## Access Services

Magento:
http://magento-enterprise.local:8080

MailHog:
http://localhost:8025

RabbitMQ:
http://localhost:15672

OpenSearch:
http://localhost:9201

## Container Names

magento_enterprise_php

magento_enterprise_nginx

magento_enterprise_db

magento_enterprise_redis

magento_enterprise_opensearch

magento_enterprise_rabbitmq

magento_enterprise_mailhog

## Useful Commands

Enter PHP Container:

```bash
docker exec -it magento_enterprise_php bash
```

Stop Containers:

```bash
docker compose down
```

Restart Containers:

```bash
docker compose up -d
```

