FROM php:7.0.3-fpm

ENV DEBIAN_FRONTEND noninteractive
COPY config/custom.ini /usr/local/etc/php/conf.d/

RUN apt-get update && apt-get install -y zlib1g-dev libicu-dev libpq-dev libfreetype6 wget gdebi libmagickwand-dev libmagickcore-dev imagemagick \
    --no-install-recommends \
    && docker-php-ext-install opcache \
    && docker-php-ext-install intl \
    && docker-php-ext-install mbstring \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install pdo_pgsql \
    ## APCu
    && pecl install apcu \
    && docker-php-ext-enable apcu \
    # Image Magick
    && pecl install imagick \
    && docker-php-ext-enable imagick

RUN wget http://download.gna.org/wkhtmltopdf/0.12/0.12.2.1/wkhtmltox-0.12.2.1_linux-jessie-amd64.deb
RUN gdebi --n wkhtmltox-0.12.2.1_linux-jessie-amd64.deb

RUN mkdir -p /var/log/php-app
RUN chown www-data:www-data /var/log/php-app

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer



