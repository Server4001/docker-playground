FROM nginx:1.10-alpine

ADD nginx/vhost.prod.conf /etc/nginx/conf.d/default.conf

# Copy Laravel's static assets into the image.
COPY public /var/www/public
