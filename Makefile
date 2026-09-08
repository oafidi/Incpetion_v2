COMPOSE = docker compose -f srcs/docker-compose.yml --env-file srcs/.env
DATA_DIR = /home/oafidi/data

all: up

up:
	mkdir -p $(DATA_DIR)/mariadb $(DATA_DIR)/wordpress
	$(COMPOSE) up --build -d

build:
	mkdir -p $(DATA_DIR)/mariadb $(DATA_DIR)/wordpress
	$(COMPOSE) build

down:
	$(COMPOSE) down

clean: down

fclean:
	$(COMPOSE) down --rmi all --volumes --remove-orphans
	sudo rm -rf /home/oafidi/data/mariadb /home/oafidi/data/wordpress

re: fclean all
