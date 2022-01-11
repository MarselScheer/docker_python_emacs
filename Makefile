IMAGE_NAME := python_emacs_ng
IMAGE_VERSION := v4

start: image
	sudo docker run --gpus all -i -t --rm \
	  -v ~/docker_fs:/tmp/hostfs \
	  -v /tmp/.X11-unix:/tmp/.X11-unix \
	  $(IMAGE_NAME):$(IMAGE_VERSION)

start-cpu: image
	sudo docker run -i -t --rm \
	  -v ~/docker_fs:/tmp/hostfs \
	  -v /tmp/.X11-unix:/tmp/.X11-unix \
	  $(IMAGE_NAME):$(IMAGE_VERSION)

start-with-sshX: image
	sudo docker run --gpus all -i -t --rm \
	  --net=host \
	  -e DISPLAY \
	  -v ~/.Xauthority:$$HOME/.Xauthority:rw \
	  -v ~/docker_fs:/tmp/hostfs \
	  $(IMAGE_NAME):$(IMAGE_VERSION)

image:
	sudo docker build -t $(IMAGE_NAME):$(IMAGE_VERSION) .

help:
	@echo start: runs the image
	@echo start-with-sshX: runs the image that allows the GUI
	@echo                  also to be forwarded via an ssh connection
	@echo image: builds the image
