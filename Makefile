PKG := .
CMD := $(PKG)/cmd/generate-api
BIN := $(PKG)/bin

# Build

.PHONY: all clean

all: clean $(BIN)

.PHONY: build
build: cmd/generate-api
	mkdir -p $(BIN) || true
	@echo "+ Building $@"
	CGO_ENABLED="0" go build -v -o $(BIN) $(CMD)

.PHONY: install
install: cmd/generate-api
	mkdir -p $(BIN) || true
	@echo "+ Building $@"
	CGO_ENABLED="0" go install -v $(CMD)

clean:
	@echo "+ Cleaning $(PKG)"
	go clean -i $(PKG)/...
	rm -rf $(BIN)
	rm -rf testdata/*_gen

# Test

# generate sources
JSON := $(wildcard test/files/*.json)
GENERATED_SOURCE := $(patsubst %.json,%_gen/generated.go,$(JSON))
test/%_gen/generated.go: testdata
	@echo "\n+ Generating code for $@"
	@D=$(shell echo $^ | sed 's/.json/_gen/'); \
	[ ! -d $$D ] && mkdir -p $$D || true
	./schema-generate -o $@ -p $(shell echo $^ | sed 's/test\///; s/.json//')  $^

.PHONY: test codecheck fmt lint vet

test: $(BIN) $(GENERATED_SOURCE)
	@echo "\n+ Executing tests for $(PKG)"
	go test -v -race -cover $(PKG)/...
    

codecheck: fmt lint vet

fmt:
	@echo "+ go fmt"
	go fmt $(PKG)/...

lint: $(GOPATH)/bin/golint
	@echo "+ go lint"
	golint -min_confidence=0.1 $(PKG)/...

$(GOPATH)/bin/golint:
	go get -v golang.org/x/lint/golint

vet:
	@echo "+ go vet"
	go vet $(PKG)/...
