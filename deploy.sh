#!/bin/bash

# Define image versions
FRONTEND_IMAGE="dsthakur402/react-frontend:v1.0"
BACKEND_IMAGE="dsthakur402/express-backend:v1.0"

# Build Docker images
echo "Building frontend Docker image..."
docker build -t $FRONTEND_IMAGE ./frontend
echo "Frontend image built successfully."

echo "Building backend Docker image..."
docker build -t $BACKEND_IMAGE ./backend
echo "Backend image built successfully."

# Push images to Docker Hub
echo "Pushing frontend image to Docker Hub..."
docker push $FRONTEND_IMAGE
echo "Frontend image pushed successfully."

echo "Pushing backend image to Docker Hub..."
docker push $BACKEND_IMAGE
echo "Backend image pushed successfully."

# Start services with Docker Compose
echo "Starting services with Docker Compose..."
docker-compose down
docker-compose up -d --build
echo "All services are up and running."

# Display running containers
docker ps
