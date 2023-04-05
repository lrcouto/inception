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

clean:
	@docker stop $$(docker ps -qa);\
	docker rm $$(docker ps -qa);\
	docker rmi -f $$(docker images -qa);\
	docker volume rm $$(docker volume ls -q);\
	docker network rm $$(docker network ls -q);\

.PHONY: all re down clean