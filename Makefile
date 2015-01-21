CONTAINER_NAME = rro-ubuntu
PUBLISH_PORT = 8787
DOCKER_ERROR := $(shell docker info 2>&1 | grep -i 'cannot connect\|fatal')
MOUNT_FOLDER := "$(HOME)/Rdata"

all: setup run
		@echo "done"

.PHONY: setup
setup:
ifneq ($(DOCKER_ERROR),)
		@echo $(DOCKER_ERROR)
		$(error make sure that docker is installed and running and that you have the correct rights)
else
		@echo "docker is running"
endif

.PHONY: clean
clean: stop
ifneq ("$(shell docker images --no-trunc | grep 'none')","")
		@echo "removing old docker images (named <none>)" 
		@docker images --no-trunc | grep 'none' | awk '{print $$3}' | xargs docker rmi -f
else
		@echo "no old docker images to remove"
endif

.PHONY: build
build: clean
		@echo "building api docker container"
		@docker build -t $(CONTAINER_NAME) ubuntu/

.PHONY: run
run: build start

.PHONY: start
start:
		@echo "starting docker container"
		@CONTAINER_ID="$(shell docker run -v $(MOUNT_FOLDER):/data -p $(PUBLISH_PORT):8787 -d $(CONTAINER_NAME))"; \
		echo $$CONTAINER_ID >> .container-id;

.PHONY: stop
stop: 
ifneq ("$(wildcard .container-id)","")
		@echo "stopping api docker containers" 
		-cat .container-id | xargs docker stop;
		@echo "removing docker container"
		-cat .container-id | xargs docker rm; \
		rm .container-id;
else
		@echo "no docker container to stop"
endif

.PHONY: bash
bash:
ifneq ("$(wildcard .container-id)","")
		@docker exec -ti $(shell cat .container-id | head -n 1) bash
else
		@echo "no docker container running"
endif
