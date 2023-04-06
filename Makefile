# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: lcouto <lcouto@student.42sp.org.br>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/04/04 23:08:08 by lcouto            #+#    #+#              #
#    Updated: 2023/04/04 23:08:08 by lcouto           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


all:
	@sudo mkdir -p /home/lcouto/data/mysql
	@docker volume create --name mariadb_volume --opt type=none --opt device=/home/lcouto/data/mysql --opt o=bind
	@sudo mkdir -p /home/lcouto/data/wordpress
	@docker volume create --name wordpress_volume --opt type=none --opt device=/home/lcouto/data/wordpress --opt o=bind
	@docker-compose -f ./srcs/docker-compose.yml up -d --build

down:
	@docker-compose -f ./srcs/docker-compose.yml down

re:
	@docker-compose -f srcs/docker-compose.yml up -d --build

update-hosts:
	@if ! grep -q "lcouto.42.fr" /etc/hosts; then \
		echo "127.0.0.1 lcouto.42.fr" >> /etc/hosts; \
	fi

list:
	@docker ps -a

list-volumes:
	@docker volume ls

list-networks:
	@docker network ls

clean: down
	@-docker stop `docker ps -qa`
	@-docker rm `docker ps -qa`
	@-docker rmi -f `docker images -qa`
	@-docker volume rm `docker volume ls -q`
	@sudo rm -rf /home/lcouto/data/wordpress
	@sudo rm -rf /home/lcouto/data/mysql

.PHONY: all re down clean