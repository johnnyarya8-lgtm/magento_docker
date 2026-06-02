#!/bin/bash

DATE=$(date +%Y%m%d_%H%M%S)

mkdir -p backups

docker exec magento_enterprise_db \
mysqldump -u root -proot magento \
> backups/magento_$DATE.sql

echo "Backup Created"
