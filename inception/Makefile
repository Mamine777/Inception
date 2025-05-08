all: up

up: create_dirs
	@docker-compose -f ./srcs/docker-compose.yml up --build -d

create_dirs:
	@mkdir -p /home/$(USER)/data/mariadb
	@mkdir -p /home/$(USER)/data/wordpress
	@sudo chown -R $(USER):$(USER) /home/$(USER)/data
	@sudo chmod -R 755 /home/$(USER)/data
	@echo "Created data directories with proper permissions"

down:
	@docker-compose -f ./srcs/docker-compose.yml down -v --remove-orphans
	@sudo rm -rf /home/$(USER)/data/

clean: down
	@docker system prune -a --force

fclean: clean
	@sudo rm -rf /home/$(USER)/data
	@docker volume prune --force
	@docker network prune --force
	@echo "Removed all data directories and Docker artifacts"

re: fclean all

.PHONY: all up down clean fclean re create_dirs
