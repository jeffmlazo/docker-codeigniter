FROM php:7.2-apache

RUN apt-get update && apt-get install -y

# Install neccessary softwares & dependencies
RUN apt-get install -y vim libicu-dev exif \
    && apt-get install --fix-missing -y libpq-dev \
    && apt-get install --no-install-recommends -y libpq-dev \
    && apt-get install -y libxml2-dev libbz2-dev zlib1g-dev \
    && apt-get install -y --fix-missing zip unzip

# Install php extensions & enable mod_rewrite in apache2
RUN docker-php-ext-install mysqli pdo_mysql intl \
    && a2enmod rewrite

# Add a virtual host configuration
ADD config/apache.conf /etc/apache2/sites-available/000-default.conf

# Copy codeigniter files to the container
COPY www/ /var/www/html

# Change access permission to the folder
RUN chmod -R 0777 /var/www/html/writable

# Clean unused files
RUN apt-get clean && \
    rm -r /var/lib/apt/lists/*
