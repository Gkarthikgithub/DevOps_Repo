#!/bin/bash
echo "Stopping existing container if running..."
docker stop php-service || true
docker rm php-service || true
