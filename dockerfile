FROM nginx:alpine

COPY . /usr/share/nginx/html

# Expose port 80 to allow external access
EXPOSE 80

