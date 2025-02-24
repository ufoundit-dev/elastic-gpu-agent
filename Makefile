ifndef TAG
GIT_COMMIT = $(shell git rev-parse "HEAD^{commit}" 2>/dev/null)
GIT_VERSION = $(shell git describe --tags --match='v*' --abbrev=14 "${GIT_COMMIT}^{commit}"||echo "v0.0.0-unknown")
TAG=$(subst v,,$(GIT_VERSION))

# re tag to internal version
TAG=$(shell cat version | grep 'version: ' | awk '{print $$2}')
endif

all: image

image:
	@echo "building elastic-gpu-agent docker image..."
	docker build -t  hub.ufoundit.com.cn/mirror/elastic-gpu-agent:$(TAG) -f Dockerfile .

test:
	echo $(TAG)

push:
	docker push hub.ufoundit.com.cn/mirror/elastic-gpu-agent:$(TAG)
