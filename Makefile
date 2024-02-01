# Makefile

all:
	@echo "Creating Volume"
	@mkdir -p /home/$(USER)/data/mariadb
	@mkdir -p /home/$(USER)/data/wordpress
	@docker-compose -f srcs/docker-compose.yml up --build -d

start:
	@docker-compose -f srcs/docker-compose.yml start

stop:
	@docker-compose -f srcs/docker-compose.yml stop

restart:
	@docker-compose -f srcs/docker-compose.yml restart

wordpress:
	@docker exec -it wordpress bash

nginx:
	@docker exec -it nginx bash
	
mariadb:
	@docker exec -it mariadb bash

fclean:
	@docker-compose -f srcs/docker-compose.yml down
	@docker system prune --all --force --volumes
	@docker network prune --force
	@docker volume prune --force
	@sudo rm -rf /home/$(USER)/data

re:	fclean all

.PHONY: build up down

