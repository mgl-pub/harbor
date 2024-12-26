export VERSION = $(shell cat version)
export VERSION_PATCH = $(shell cat version_patch)

all: dep patch

dep:
	git submodule update --init --recursive
	git submodule update --force --remote
	git submodule foreach -q --recursive 'git reset --hard && git checkout ${VERSION}'

patch:
	cd harbor && sh -c "curl https://github.com/goharbor/harbor/compare/$(VERSION)...morlay:patch-$(VERSION_PATCH).patch | git apply -v"

