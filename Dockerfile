FROM nginx:1.27-alpine

COPY nginx.conf  /etc/nginx/conf.d/default.conf
COPY index.html  /usr/share/nginx/html/index.html

EXPOSE 80

# busybox wget ships in the alpine base, so no extra packages are needed.
# Address 127.0.0.1 explicitly: /etc/hosts maps "localhost" to ::1 as well, and
# busybox wget tries that first, which nginx (IPv4-only here) refuses.
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD wget -q --spider http://127.0.0.1/ || exit 1
