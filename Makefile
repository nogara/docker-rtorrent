NAME=rtorrent
REPO=edgard/$(NAME)

.PHONY: build start test test-stop run push

all: build

build:
	docker build -t $(REPO) .

start:
	docker run -d --name $(NAME) -p 80:80 -p 63256:63256 -v /srv/$(NAME):/data $(REPO)

test:
	mkdir -p /tmp/$(NAME)-test/data/config/
	cp -f $(CURDIR)/files/root/data/config/rtorrent.rc /tmp/$(NAME)-test/data/config/
	docker run -d --name $(NAME)-test -p 80:80 -p 63256:63256 -v /tmp/$(NAME)-test/data:/data $(REPO)

test-stop:
	docker stop $(NAME)-test
	docker rm $(NAME)-test

run:
	mkdir -p /tmp/$(NAME)-run/data/config/
	cp -f $(CURDIR)/files/root/data/config/rtorrent.rc /tmp/$(NAME)-run/data/config/
	docker run -t -i -p 80:80 -p 63256:63256 -v /tmp/$(NAME)-run/data:/data --rm $(REPO) /bin/bash

push:
	docker push $(REPO)
