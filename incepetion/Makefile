NAME = inception

.PHONY: all up down build clean fclean re

all: up

up:
	@echo "🔼 Starting containers..."
	@cd srcs && docker-compose up -d --build

down:
	@echo "🧯 Stopping containers..."
	@cd srcs && docker-compose down

build:
	@echo "🔨 Building containers..."
	@cd srcs && docker-compose build

clean:
	@echo "🧼 Removing containers and volumes..."
	@cd srcs && docker-compose down -v

fclean: clean
	@echo "🗑️ Removing Docker images..."
	@cd srcs && docker rmi -f $$(docker images -q srcs_nginx srcs_wordpress srcs_mariadb 2>/dev/null || true) || true

re: fclean all