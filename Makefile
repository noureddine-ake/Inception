
up:
	mkdir -p ./volumes/wordpress
	mkdir -p ./volumes/mariadb
	docker-compose -f srcs/docker-compose.yml up --build

down:
	docker-compose -f srcs/docker-compose.yml down

prune:
	docker system prune -af --volumes

clean:
	docker-compose -f srcs/docker-compose.yml down -v

clean-images: clean
	@images=$$(docker images -q); \
	if [ -n "$$images" ]; then \
	    docker rmi $$images; \
	fi

fclean: clean-images
	rm -rf ./volumes/mariadb/*
	rm -rf ./volumes/wordpress/*

re: fclean up

.PHONY: clean fclean down up prune clean-images
