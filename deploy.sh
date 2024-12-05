#!/bin/bash

# Variables
FRONTEND_VERSION="v1.0.0"
BACKEND_VERSION="v1.0.0"
DOCKERHUB_USERNAME="dsthakur402"
DOCKERHUB_PASSWORD=${{ secrets.PASSWORD }}

# Ensure secrets are accessible
if [[ -z "$DOCKERHUB_USERNAME" || -z "$DOCKERHUB_PASSWORD" ]]; then
    echo "Error: Docker Hub username or password secrets are not set."
    exit 1
fi

# Step 1: Authenticate with Docker Hub
echo "Authenticating with Docker Hub..."
echo "$DOCKERHUB_PASSWORD" | docker login --username "$DOCKERHUB_USERNAME" --password-stdin
if [ $? -ne 0 ]; then
    echo "Docker Hub authentication failed. Please check your credentials."
    exit 1
fi

# Step 2: Build Docker images for frontend and backend
echo "Building Docker images..."
docker build -f frontend/Dockerfile1 -t "$DOCKERHUB_USERNAME/frontend:$FRONTEND_VERSION" ./frontend
if [ $? -ne 0 ]; then
    echo "Error building frontend image."
    exit 1
fi

docker build -f backend/Dockerfile2 -t "$DOCKERHUB_USERNAME/backend:$BACKEND_VERSION" ./backend
if [ $? -ne 0 ]; then
    echo "Error building backend image."
    exit 1
fi

# Step 3: Push Docker images to Docker Hub
echo "Pushing Docker images to Docker Hub..."
docker push "$DOCKERHUB_USERNAME/frontend:$FRONTEND_VERSION"
if [ $? -ne 0 ]; then
    echo "Error pushing frontend image."
    exit 1
fi

docker push "$DOCKERHUB_USERNAME/backend:$BACKEND_VERSION"
if [ $? -ne 0 ]; then
    echo "Error pushing backend image."
    exit 1
fi

# Step 4: Update docker-compose.yml file with new image versions
echo "Updating docker-compose.yml with new image versions..."
sed -i "s|frontend:.*|frontend: $DOCKERHUB_USERNAME/frontend:$FRONTEND_VERSION|" docker-compose.yml
sed -i "s|backend:.*|backend: $DOCKERHUB_USERNAME/backend:$BACKEND_VERSION|" docker-compose.yml
if [ $? -ne 0 ]; then
    echo "Error updating docker-compose.yml."
    exit 1
fi

# Step 5: Pull updated images and run Docker Compose to start the application
echo "Pulling updated Docker images..."
docker-compose pull
if [ $? -ne 0 ]; then
    echo "Error pulling updated Docker images."
    exit 1
fi

echo "Running Docker Compose to start the application..."
docker-compose up --build -d
if [ $? -ne 0 ]; then
    echo "Error starting application with Docker Compose."
    exit 1
fi

# Step 6: Optional cleanup of old images (if necessary)
echo "Cleaning up old Docker images..."
docker image prune -f
if [ $? -ne 0 ]; then
    echo "Error during image cleanup."
    exit 1
fi

echo "Deployment complete!"
