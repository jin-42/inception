FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    nginx \
    openssl \
    && rm -rf /var/lib/apt/lists/*

# Create SSL directory
RUN mkdir -p /etc/nginx/ssl

# Generate SSL certificate
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt \
    -subj "/C=FR/ST=Rhone/L=Lyon/O=42/OU=42Lyon/CN=fsulvac.42.fr"

# Copy nginx configuration
COPY conf/nginx.conf /etc/nginx/sites-available/default

# Create nginx user
RUN mkdir -p /var/run/nginx

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
