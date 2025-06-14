FROM dart:stable AS build

# Install Flutter dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    wget \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Install Flutter
ENV FLUTTER_HOME="/opt/flutter"
RUN git clone https://github.com/flutter/flutter.git -b stable $FLUTTER_HOME
ENV PATH="$FLUTTER_HOME/bin:$PATH"

# Configure Flutter
RUN flutter config --no-analytics
RUN flutter config --enable-web
RUN flutter precache --web

# Set working directory
WORKDIR /app

# Copy pubspec files
COPY pubspec.yaml pubspec.lock ./

# Get dependencies
RUN flutter pub get

# Copy source code
COPY . .

# Build web app
RUN flutter build web --release

# Production stage
FROM nginx:alpine

# Copy built app
COPY --from=build /app/build/web /usr/share/nginx/html

# Create nginx config
COPY <<EOF /etc/nginx/nginx.conf
events {
    worker_connections 1024;
}
http {
    include /etc/nginx/mime.types;
    default_type application/octet-stream;
    
    server {
        listen 8080;
        root /usr/share/nginx/html;
        index index.html;
        
        location / {
            try_files \$uri \$uri/ /index.html;
        }
    }
}
EOF

EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]