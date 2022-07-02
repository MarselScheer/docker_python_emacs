IMAGE_NAME := python_emacs_ng
IMAGE_VERSION := v8_qa

start: image
	@echo ----- $@ ----- $$(date)
	sudo docker run --gpus all -i -t --rm \
	  -v ~/docker_fs:/tmp/hostfs \
	  -v /tmp/.X11-unix:/tmp/.X11-unix \
	  --net docker_python_emacs_default \
	  $(IMAGE_NAME):$(IMAGE_VERSION)

start-cpu: image
	@echo ----- $@ ----- $$(date)
	sudo docker run -i -t --rm \
	  -v ~/docker_fs:/tmp/hostfs \
	  -v /tmp/.X11-unix:/tmp/.X11-unix \
	  --net docker_python_emacs_default \
	  $(IMAGE_NAME):$(IMAGE_VERSION)

start-with-sshX: image
	@echo ----- $@ ----- $$(date)
	sudo docker run --gpus all -i -t --rm \
	  --net=host \
	  -e DISPLAY \
	  -v ~/.Xauthority:$$HOME/.Xauthority:rw \
	  -v ~/docker_fs:/tmp/hostfs \
	  --net docker_python_emacs_default \
	  $(IMAGE_NAME):$(IMAGE_VERSION)

image:
	@echo ----- $@ ----- $$(date)
	sudo docker build -t $(IMAGE_NAME):$(IMAGE_VERSION) .

help:
	@echo ----- $@ ----- $$(date)
	@echo start: runs the image giving access to the host-gpu
	@echo start-cpu: runs the image (no acces to host-gpu)
	@echo start-with-sshX: runs the image that allows the GUI
	@echo                  also to be forwarded via an ssh connection
	@echo image: builds the image
