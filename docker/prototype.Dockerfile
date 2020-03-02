ARG PROTOTYPE_IMAGE_VERSION=latest
FROM docker.pkg.github.com/ampersandtarski/prototype/prototype-framework:${PROTOTYPE_IMAGE_VERSION}

ADD . /usr/local/project

ARG DB_HOST=db
ARG SCRIPT=script.adl

# Generate prototype application from folder
RUN ampersand proto /usr/local/project/${SCRIPT} \
      --output-directory /var/www \
      --sqlHost ${DB_HOST} \
      --verbose \
      --skip-composer

RUN chown -R www-data:www-data /var/www/log /var/www/data /var/www/generics \
 && cd /var/www \
 # && composer install --prefer-dist --no-dev --optimize-autoloader --profile \
 # && npm install \
 # && gulp build-ampersand \
 # && gulp build-project