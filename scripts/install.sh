#!/bin/bash

echo "==================================="
echo "Magento Enterprise Setup"
echo "==================================="

docker compose build

docker compose up -d

echo ""
echo "Containers Started Successfully"
echo ""
echo "Next Step:"
echo "docker exec -it magento_enterprise_php bash"
