NAME = inception
VOLUMES = wordpress_data mariadb_data

all: build up

build:
	docker-compose build

up:
	docker-compose up -d

down:
	docker-compose down

clean: down
	docker system prune -f

fclean: clean
	docker volume rm $(VOLUMES) 2>/dev/null || true
	docker system prune -af --volumes

re: fclean all

logs:
	docker-compose logs -f

ps:
	docker-compose ps

.PHONY: all build up down clean fclean re logs ps 