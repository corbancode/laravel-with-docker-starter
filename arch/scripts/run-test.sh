#!/usr/bin/env bash

echo ">>Installing dependencies..."
composer install
echo ">>Running test..."
composer test
