
BUILD_IMAGE = keepalived-build

build: 
	docker build -t $(BUILD_IMAGE) .
	docker cp `docker create $(BUILD_IMAGE)`:/tmp/genhash  bin/
	docker cp `docker create $(BUILD_IMAGE)`:/tmp/keepalived bin/

.PHONY: build
