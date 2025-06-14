FROM node:18-alpine AS test

# Test basic functionality
RUN echo "Docker build test successful"

# Simple web server stage
FROM nginx:alpine

# Copy a simple HTML file
RUN echo '<html><body><h1>APB TA New - Test Deployment</h1></body></html>' > /usr/share/nginx/html/index.html

# Simple nginx config
RUN echo 'server { listen 8080; location / { root /usr/share/nginx/html; index index.html; } }' > /etc/nginx/conf.d/default.conf
RUN rm /etc/nginx/conf.d/default.conf

# Create minimal config
RUN echo 'events { worker_connections 1024; } http { server { listen 8080; root /usr/share/nginx/html; index index.html; location / { try_files $uri $uri/ /index.html; } } }' > /etc/nginx/nginx.conf

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]