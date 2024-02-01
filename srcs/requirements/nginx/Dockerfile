# Use the penultimate stable version of Debian
FROM debian:bullseye

# Install NGINX and OpenSSL
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y nginx openssl

RUN mkdir /etc/nginx/crt

RUN openssl req -newkey rsa:4096 -x509 \
    -days 365 -nodes \
    -out /etc/nginx/crt/vstockma.crt \
    -keyout /etc/nginx/crt/vstockma.key \
    -subj "/C=AT/L=Vienna/O=42/CN=vstockma/"

COPY ./nginx.conf /etc/nginx/conf.d

EXPOSE 443

RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log


CMD ["nginx", "-g", "daemon off;"]

