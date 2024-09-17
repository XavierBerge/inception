DOCKER_COMPOSE_FILE = ./srcs/docker-compose.yml

all: up

up:
	@echo "Starting docker-compose..."
	@sudo mkdir -p /home/$(USER)/data/mariadb/ /home/$(USER)/data/wordpress/
	@docker-compose -f $(DOCKER_COMPOSE_FILE) up -d

down:
	@echo "Stopping docker-compose..."
	@docker-compose -f $(DOCKER_COMPOSE_FILE) down

restart:
	@echo "Restarting docker-compose..."
	@docker-compose -f $(DOCKER_COMPOSE_FILE) down
	@docker-compose -f $(DOCKER_COMPOSE_FILE) up -d

logs:
	@echo "Displaying logs..."
	@docker-compose -f $(DOCKER_COMPOSE_FILE) logs -f

clean:
	@echo "Stopping and removing containers, networks, volumes..."
	@docker-compose -f $(DOCKER_COMPOSE_FILE) down --volumes --remove-orphans
	@sudo rm -rf /home/$(USER)/data/mariadb/ /home/$(USER)/data/wordpress/

purge:
	@echo "Purging all Docker containers, images, volumes, and networks..."
	@docker ps -qa | xargs -r docker stop
	@docker ps -qa | xargs -r docker rm
	@docker images -qa | xargs -r docker rmi -f
	@docker volume ls -q | xargs -r docker volume rm
	@docker network ls -q | grep -v "bridge\|host\|none" | xargs -r docker network rm 2>/dev/null || true

re: clean all

.PHONY: all up down restart logs clean purge

