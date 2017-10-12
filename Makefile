VERSION ?= latest

REPO = dakku/drupal-vm
NAME = drupal-vm

.PHONY: build shell run start stop logs clean release

build:
	docker build -t $(REPO):$(VERSION) ./

shell:
	docker run --rm --name $(NAME) -i -t $(ENV) $(REPO):$(VERSION) /bin/bash

run:
	docker run --rm --name $(NAME) $(ENV) $(REPO):$(VERSION) $(CMD)

start:
	docker run -d --name $(NAME) $(ENV) $(REPO):$(VERSION)

stop:
	docker stop $(NAME)

logs:
	docker logs $(NAME)

clean:
	docker rm -f $(NAME)

release: build
	make push -e VERSION=$(VERSION)

default: build
