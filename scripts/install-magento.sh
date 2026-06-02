#!/bin/bash

set -e

echo "===================================="
echo "Magento Enterprise Installer"
echo "===================================="

# Load Environment Variables
if [ -f .env ]; then
    export $(grep -v '^#' .env | xargs)
fi

echo ""
echo "Magento Version : $MAGENTO_VERSION"
echo "Database Host   : mariadb"
echo "Redis Host      : redis"
echo "OpenSearch Host : opensearch"
echo ""

echo "Checking PHP Container..."

docker ps | grep magento_enterprise_php > /dev/null

echo "PHP Container Running"

echo ""
echo "Checking MariaDB..."

docker exec magento_enterprise_db \
mariadb \
-u root \
-p${MYSQL_ROOT_PASSWORD} \
-e "SELECT 1;" > /dev/null

echo "MariaDB Ready"

echo ""
echo "Checking Redis..."

docker exec magento_enterprise_redis \
redis-cli ping

echo ""
echo "Checking OpenSearch..."

docker exec magento_enterprise_opensearch \
curl -s http://localhost:9200 > /dev/null

echo "OpenSearch Ready"

echo ""
echo "All Services Healthy"

echo ""
echo "Checking Magento Source Directory..."

if [ -f "src/composer.json" ]; then

    echo "Magento Source Already Exists"

else

    echo "Downloading Magento ${MAGENTO_VERSION}..."

    docker exec \
    magento_enterprise_php \
    composer config --global \
    http-basic.repo.magento.com \
    ${MAGENTO_PUBLIC_KEY} \
    ${MAGENTO_PRIVATE_KEY}

    docker exec \
    -w /var/www/html \
    magento_enterprise_php \
    composer create-project \
    --repository-url=https://repo.magento.com/ \
    magento/project-community-edition=${MAGENTO_VERSION} .

fi

echo ""
echo "Checking Magento Installation..."

if [ -f "src/app/etc/env.php" ]; then
    echo "Magento Already Installed"
    exit 0
fi

echo ""
echo "Starting Magento Installation..."

docker exec \
-w /var/www/html \
magento_enterprise_php \
php bin/magento setup:install \
--base-url=${MAGENTO_BASE_URL} \
--db-host=mariadb \
--db-name=${MYSQL_DATABASE} \
--db-user=${MYSQL_USER} \
--db-password=${MYSQL_PASSWORD} \
--admin-firstname=${ADMIN_FIRSTNAME} \
--admin-lastname=${ADMIN_LASTNAME} \
--admin-email=${ADMIN_EMAIL} \
--admin-user=${ADMIN_USER} \
--admin-password=${ADMIN_PASSWORD} \
--language=${MAGENTO_LANGUAGE} \
--currency=${MAGENTO_CURRENCY} \
--timezone=${MAGENTO_TIMEZONE} \
--use-rewrites=1 \
--search-engine=opensearch \
--opensearch-host=opensearch \
--opensearch-port=9200
