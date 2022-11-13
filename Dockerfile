FROM nginx
COPY website/public /usr/share/nginx/html

EXPOSE 80