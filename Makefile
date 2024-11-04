# Makefile

# Variables
IMAGE_NAME := sample-app
CONTAINER_NAME := flask-sample-app
PORT := 8080

pre-commit-install:
	@chmod +x pre-commit
	@cp pre-commit ./.git/hooks/
	@echo "pre-commit installed"

# Build the Docker image
build:
	docker build -t $(IMAGE_NAME) .

# Run the Docker container
run: pre-commit-install build
	docker run  --rm --name $(CONTAINER_NAME) -p $(PORT):8080 $(IMAGE_NAME) 

# Stop the Docker container
stop:
	docker stop $(CONTAINER_NAME)
	docker rm $(CONTAINER_NAME)

# Clean up the Docker image
clean:
	docker rmi $(IMAGE_NAME)

# Rebuild and restart the container
restart: stop build run
