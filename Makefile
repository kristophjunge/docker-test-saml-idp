SHELL = /bin/bash
.SILENT:

VERSIONS_FILE ?= $(CURDIR)/versions.json
REPOSITORY ?= ghcr.io/kuisathaverat/docker-test-saml-idp
VERSION ?= $(shell jq -r .version "$(VERSIONS_FILE)")
SIMPLESAMLPHP_VERSION ?= $(shell jq -r .simplesamlphp_version "$(VERSIONS_FILE)")

SIMPLESAMLPHP_SP_ENTITY_ID ?= http://app.example.com
SIMPLESAMLPHP_SP_ASSERTION_CONSUMER_SERVICE ?= http://localhost/simplesaml/module.php/saml/sp/saml2-acs.php/test-sp
SIMPLESAMLPHP_SP_SINGLE_LOGOUT_SERVICE ?= http://localhost/simplesaml/module.php/saml/sp/saml2-logout.php/test-sp
SIMPLESAMLPHP_SESSION_DURATION ?= $$(( 8 * 60 * 60 ))

.PHONY: help
help:
	@echo "Environment variables:"
	@echo ""
	@echo "VERSION=$(VERSION)"
	@echo "VERSIONS_FILE=$(VERSIONS_FILE)"
	@echo "REPOSITORY=$(REPOSITORY)"
	@echo "SIMPLESAMLPHP_VERSION=$(SIMPLESAMLPHP_VERSION)"
	@echo "SIMPLESAMLPHP_SP_ENTITY_ID=$(SIMPLESAMLPHP_SP_ENTITY_ID)"
	@echo "SIMPLESAMLPHP_SP_ASSERTION_CONSUMER_SERVICE=$(SIMPLESAMLPHP_SP_ASSERTION_CONSUMER_SERVICE)"
	@echo "SIMPLESAMLPHP_SP_SINGLE_LOGOUT_SERVICE=$(SIMPLESAMLPHP_SP_SINGLE_LOGOUT_SERVICE)"
	@echo "SIMPLESAMLPHP_SESSION_DURATION=$(SIMPLESAMLPHP_SESSION_DURATION)"
	@echo ""
	@echo "Targets:"
	@echo ""
	@grep '^## @help' Makefile|cut -d ":" -f 2-3|( (sort|column -s ":" -t) || (sort|tr ":" "\t") || (tr ":" "\t"))

## @help:build:Build the Docker container.
.PHONY: build
build:
	docker build \
		--build-arg SIMPLESAMLPHP_VERSION=$(SIMPLESAMLPHP_VERSION) \
		-t "$(REPOSITORY):$(VERSION)" .

## @help:publish:Build and Publish the Docker container.
.PHONY: publish
publish: build
	docker push "$(REPOSITORY):$(VERSION)"

## @help:run:Launch ghcr.io/kuisathaverat/docker-test-saml-idp:latest Docker container.
.PHONY: run
run:
	docker run --name=testsamlidp_idp \
	-p 8080:8080 \
	-p 8443:8443 \
	-e SIMPLESAMLPHP_SP_ENTITY_ID \
	-e SIMPLESAMLPHP_SP_ASSERTION_CONSUMER_SERVICE \
	-e SIMPLESAMLPHP_SP_SINGLE_LOGOUT_SERVICE \
	-e SIMPLESAMLPHP_SESSION_DURATION \
	-d ghcr.io/kuisathaverat/docker-test-saml-idp:latest

## @help:release:Perform a new release in GitHub
.PHONY: release
release:
	gh release create "$(VERSION)" --title "$(VERSION)"
