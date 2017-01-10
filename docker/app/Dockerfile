FROM php:7.0-fpm

MAINTAINER Jason Raimondi <jason@raimondi.us>

RUN apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62 \
    && echo "deb http://nginx.org/packages/mainline/debian/ jessie nginx" >> /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y \
        ca-certificates \
        nginx \
        pkg-config \
        curl \
        cron \
        supervisor \
        git \
        vim \
        openssl

RUN apt-get install -y \
        libfcgi-dev libfcgi0ldbl libjpeg62-turbo-dbg libmcrypt-dev \
        libssl-dev libc-client2007e libc-client2007e-dev libxml2-dev \
        libbz2-dev libcurl4-openssl-dev libjpeg-dev libpng12-dev \
        libfreetype6-dev libkrb5-dev libpq-dev libxml2-dev libxslt1-dev \
        libc-client-dev \
    && apt-get install -y \
        mysql-client sqlite3 \
    && apt-get clean

RUN ln -s /usr/lib/libc-client.a /usr/lib/x86_64-linux-gnu/libc-client.a

RUN docker-php-ext-install tokenizer \
        mbstring \
        mcrypt \
        opcache \
        exif \
        mysqli \
        zip

RUN mkdir -p /usr/include \
    && docker-php-ext-configure gd --with-gd --with-freetype-dir=/usr/include/ --with-png-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd

RUN rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/www/html \
    && rm /etc/nginx/conf.d/default.conf  

RUN { \
		echo 'opcache.memory_consumption=128'; \
		echo 'opcache.interned_strings_buffer=8'; \
		echo 'opcache.max_accelerated_files=4000'; \
		echo 'opcache.revalidate_freq=2'; \
		echo 'opcache.fast_shutdown=1'; \
		echo 'opcache.enable_cli=1'; \
	} > /usr/local/etc/php/conf.d/opcache-recommended.ini

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer

COPY ./etc/supervisord.conf /etc/supervisord.conf

COPY ./var/crontab.txt /var/crontab.txt
RUN crontab /var/crontab.txt
RUN chmod 600 /etc/crontab

COPY ./etc/nginx/nginx.conf /etc/nginx/nginx.conf
ADD ./etc/nginx/conf.d/ /etc/nginx/conf.d

# ADD ./etc/php/fpm/php-fpm.d/ /usr/local/etc/php-fpm.d
# COPY ./etc/php/fpm/php.ini /usr/local/etc/php/php.ini

WORKDIR /var/www/html

EXPOSE 80 443 9000

COPY ./bin/run.sh /usr/local/bin/
RUN chmod a+x /usr/local/bin/run.sh

CMD /usr/local/bin/run.sh
