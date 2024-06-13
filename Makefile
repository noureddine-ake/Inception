
up:
	mkdir -p /home/nakebli/data/wordpress
	mkdir -p /home/nakebli/data/mariadb
	docker-compose -f srcs/docker-compose.yml up --build

prune:
	docker system prune -af --volumes

clean:
	docker-compose -f srcs/docker-compose.yml down -v

clean-images: clean
	@images=$$(docker images -q); \
	if [ -n "$$images" ]; then \
	    docker rmi $$images; \
	fi

fclean: clean-images clean 
	rm -rf /home/nakebli/data/mariadb/*
	rm -rf /home/nakebli/data/wordpress/*

re: fclean up

.PHONY: clean fclean down up prune clean-images
