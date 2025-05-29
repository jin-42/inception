UNAME := $(shell uname)
ifeq ($(UNAME), Darwin)  # macOS
	DATA_DIR := /Users/$(USER)/data
else                     # Linux
	DATA_DIR := /home/$(USER)/data
endif

COMPOSE_FILE=srcs/docker-compose.yml

build:
	docker-compose -f $(COMPOSE_FILE) build

up:
	docker-compose -f $(COMPOSE_FILE) up -d

logs:
	docker-compose -f $(COMPOSE_FILE) logs -f

stop:
	docker-compose -f $(COMPOSE_FILE) down

clean:
	sudo rm -rf $(DATA_DIR)
	docker-compose -f $(COMPOSE_FILE) down -v --rmi all
