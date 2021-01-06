.DEFAULT_GOAL = help

require-%:
	if [ "${${*}}" = "" ]; then \
	        echo "ERROR: Environment variable not set: \"$*\""; \
	        exit 1; \
	fi

## Build base kustomization
build-base:
	kustomize build base

## Build base-app kustomization
build-base-app:
	kustomize build overlays/basic_app

## Apply base-app to cluster
apply-base-app:
	kubectl apply -k overlays/basic_app

## Remove base-app from the cluster
remove-base-app:
	kubectl delete -k overlays/basic_app

## Show help screen.
help:
	@echo "Please use \`make <target>' where <target> is one of\n"
	@awk '/^[a-zA-Z\-\_0-9]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf "%-30s %s\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)
