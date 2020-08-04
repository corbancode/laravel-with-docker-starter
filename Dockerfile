FROM php:7.4-fpm-alpine

LABEL maintainer="Ayomide Olakulehin <oayomideelijah@gmail.com>"

# Arguments defined in docker-compose.yml
ARG user

RUN apk add --update icu \
        zlib-dev \
        icu-dev \
        libpng-dev \
        libzip-dev \
        make \
        bash \
        supervisor \
        git \
        vim \
        curl \
        nginx \
        gettext \
    && docker-php-ext-configure intl \
    && docker-php-ext-install zip mysqli tokenizer opcache pdo pdo_mysql gd intl  \
    && docker-php-ext-enable intl \
    && rm -rf /tmp/* /usr/local/lib/php/doc/* /var/cache/apk/*

RUN apk add --update busybox-suid

# prepare a user which runs everything locally!
RUN adduser --disabled-password -s /bin/bash ${user}
# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
# Create nginx pid directory
RUN mkdir -p /run/nginx

COPY ./arch/php/laravel.ini  /usr/local/etc/php/conf.d
COPY ./arch/php/xlaravel.pool.conf /usr/local/etc/php-fpm.d/
COPY ./arch/php/php72.ini /usr/local/etc/php/php.ini

COPY ./arch/scripts/start.sh /usr/local/bin/start.sh
COPY ./arch/scripts/repo.sh /usr/local/bin/repo.sh

RUN chmod +x /usr/local/bin/start.sh && chmod +x /usr/local/bin/repo.sh

COPY ./arch/supervisor/supervisord.conf /etc/supervisord.conf

RUN chmod +x /etc/supervisord.conf

# Create supervisor config folder
RUN mkdir -p /etc/supervisor/conf.d

#set the terminal to xterm
RUN export TERM=xterm

# Set working directory
WORKDIR /var/www

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["start.sh"]
