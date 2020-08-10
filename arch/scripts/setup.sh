#!/usr/bin/env bash

if [[ "${APP_ENV}" = "local" ]]
then
    echo ">>Installing dependencies..."
    composer install
else
    echo ">>Installing dependencies without dev..."
    composer install --no-dev
    echo ">>Copying environment..."
    cp ".env.${APP_ENV}" ".env"
    echo ">>Giving permission..."
    chown -R www-data:root .
fi

if [[ -z "${APP_KEY}" ]]; then
    echo ">>Generating application secret key..."
    php artisan key:generate
fi
echo ">>Running migration..."
php artisan migrate
echo ">>Seeding..."
php artisan db:seed
echo ">>Publishing vendor..."
php artisan vendor:publish -n
echo ">>removing storage symbolic link..."
rm -rf "$WORKING_DIR/$APP_WORKSPACE/public/storage"
echo ">>Linking storage..."
php artisan storage:link
if [[ "${APP_ENV}" != "local" ]]
then
    echo ">> Performing optimization..."
    php artisan optimize
fi

SCHEDULE_FREQUENCY="0 * * * *"
SCHEDULE_SCRIPT="cd $WORKING_DIR/$APP_WORKSPACE && php artisan schedule:run >> /dev/null 2>&1"
if crontab -l | grep -q "${SCHEDULE_SCRIPT}"; then
    echo ">> $(date) : Job already exist";
else
    echo ">> $(date) : Adding job to crontab...";
    echo "$(echo "${SCHEDULE_FREQUENCY} ${SCHEDULE_SCRIPT}"; crontab -l)" | crontab -
fi

echo ">>Copying queue supervisor..."
cp "$WORKING_DIR/$APP_WORKSPACE/arch/supervisor/workers/"*.conf /etc/supervisor/conf.d/
/usr/bin/supervisord -n -c /etc/supervisord.conf -u root &

