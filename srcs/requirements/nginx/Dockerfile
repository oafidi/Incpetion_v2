FROM debian:bookworm

RUN apt-get update \
    && apt-get install -y nginx openssl

RUN mkdir -p /etc/nginx/ssl \
    && openssl req \
        -x509 \
        -nodes \
        -newkey rsa:2048 \
        -days 365 \
        -keyout /etc/nginx/ssl/nginx.key \
        -out /etc/nginx/ssl/nginx.crt \
        -subj "/CN=oafidi.42.fr" \
    && chmod 600 /etc/nginx/ssl/nginx.key \
    && chmod 644 /etc/nginx/ssl/nginx.crt

COPY conf/nginx.conf /etc/nginx/nginx.conf

CMD ["nginx", "-g", "daemon off;"]