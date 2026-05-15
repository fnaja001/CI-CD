#!/bin/bash
# Start the container in the background
docker run -d --name test-cicd -p 8000:8000 ${{ secrets.DOCKERHUB_USERNAME }}/cicd-app:test

# Wait for it to start
sleep 3

# Check health endpoint
response=$(curl -s http://localhost:8000/health)
if [ "$response" != "OK" ]; then
  echo "Health check failed: $response"
  exit 1
fi
echo "Health check passed"

# Cleanup
docker stop test-cicd && docker rm test-cicd
