FROM ubuntu:20.04 as builder

# Install Flutter dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    wget \
    unzip \
    libgconf-2-4 \
    gdb \
    libstdc++6 \
    libglu1-mesa \
    fonts-droid-fallback \
    lib32stdc++6 \
    python3 \
    && rm -rf /var/lib/apt/lists/*

# Install Flutter
ENV FLUTTER_HOME="/opt/flutter"
RUN git clone https://github.com/flutter/flutter.git $FLUTTER_HOME
ENV PATH="$FLUTTER_HOME/bin:$PATH"

# Configure Flutter
RUN flutter config --enable-web
RUN flutter precache --web

# Set working directory
WORKDIR /app

# Copy pubspec files and get dependencies
COPY pubspec.yaml pubspec.lock ./
RUN flutter pub get

# Copy source code
COPY . .

# Build web app (disable icon tree shaking)
RUN flutter build web --release --no-tree-shake-icons

# Production stage
FROM nginx:alpine

# Copy built web app from builder stage
COPY --from=builder /app/build/web /usr/share/nginx/html

# NGINX config for Flutter web routing
RUN echo 'events { worker_connections 1024; } \
    http { \
    include /etc/nginx/mime.types; \
    default_type application/octet-stream; \
    server { \
    listen 8080; \
    root /usr/share/nginx/html; \
    index index.html; \
    location / { \
    try_files $uri $uri/ /index.html; \
    } \
    } \
    }' > /etc/nginx/nginx.conf

EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]
