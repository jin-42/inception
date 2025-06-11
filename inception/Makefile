all: build up

build:
	@echo "Building Docker images..."
	@mkdir -p /home/fsulvac/data/mariadb
	@mkdir -p /home/fsulvac/data/wordpress
	@docker-compose -f srcs/docker-compose.yml --env-file srcs/.env build

up:
	@echo "Starting containers..."
	@docker-compose -f srcs/docker-compose.yml --env-file srcs/.env up -d

down:
	@echo "Stopping containers..."
	@docker-compose -f srcs/docker-compose.yml --env-file srcs/.env down

clean: down
	@echo "Removing containers and networks..."
	@docker system prune -af
	@docker volume rm $$(docker volume ls -q) 2>/dev/null || true

fclean: clean
	@echo "Removing all Docker data..."
	@sudo rm -rf /home/fsulvac/data
	@docker system prune -af --volumes

re: fclean all

logs:
	@docker-compose -f srcs/docker-compose.yml --env-file srcs/.env logs -f

status:
	@docker-compose -f srcs/docker-compose.yml --env-file srcs/.env ps

.PHONY: all build up down clean fclean re logs status
