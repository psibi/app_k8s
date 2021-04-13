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

## Build basic-nginx-app kustomization
build-basic-nginx-app:
	kustomize build overlays/app_nginx

## Apply basic-nginx-app to cluster
apply-basic-nginx-app:
        # Need this workaround because of upstream issue: https://github.com/kubernetes-sigs/kustomize/issues/1373#issuecomment-618439078
	kustomize build overlays/app_nginx > nginx_app.yaml
	kubectl apply -f nginx_app.yaml

## Remove basic-nginx-app from the cluster
remove-basic-nginx-app:
	kubectl delete -f nginx_app.yaml

## Build app_self_ssl_nginx overlay
build-self-nginx-app:
	kustomize build overlays/app_self_ssl_nginx

## Build app_self_ssl_nginx overlay
apply-self-nginx-app:
	kustomize build overlays/app_self_ssl_nginx > nginx_app.yaml
	kubectl apply -f nginx_app.yaml

## Remove basic-nginx-app from the cluster
remove-self-nginx-app:
	kubectl delete -f nginx_app.yaml

## Build app-secret-nginx overlay
build-app-secret-nginx:
	kustomize build overlays/app_secrets_nginx

## Build app-secret-nginx overlay
apply-app-secret-nginx:
	kustomize build overlays/app_secrets_nginx > nginx_app.yaml
	kubectl apply -f nginx_app.yaml

## Remove app-secret-nginx from the cluster
remove-app-secret-nginx:
	kubectl delete -f nginx_app.yaml

## Build app_ssl_nginx overlay
build-ssl-nginx-app:
	kustomize build overlays/app_ssl_nginx

## Apply app-ssl-nginx overlay
apply-ssl-nginx:
	kustomize build overlays/app_ssl_nginx > nginx_app.yaml
	kubectl apply -f nginx_app.yaml

## Remove app-ssl-nginx from the cluster
remove-ssl-nginx:
	kubectl delete -f nginx_app.yaml

## Build istio overlay
build-istio-app:
	kustomize build overlays/istio

## Apply istio overlay
apply-istio-app:
	kustomize build overlays/istio > istio.yaml
	kubectl apply -f istio.yaml
	kubectl apply -f overlays/istio/certificate.yaml

## Remove istio overlay
remove-istio-app:
	kubectl delete -f istio.yaml
	kubectl delete -f overlays/istio/certificate.yaml
	kubectl delete secret/httpbin-ingress-cert -n istio-system

## Build monitoring overlay
build-monitoring-app:
	kustomize build overlays/monitoring

## Apply monitoring overlay
apply-monitoring-app:
	kustomize build overlays/monitoring > monitoring.yaml
	kubectl apply -f monitoring.yaml

## Remove monitoring overlay
remove-monitoring-app:
	kubectl delete -f monitoring.yaml

## Build monitoring-istio-perm overlay
build-monitoring-istio-perm-app:
	kustomize build overlays/monitoring-istio-permissive

## Apply monitoring-istio-perm overlay
apply-monitoring-istio-perm-app:
	kustomize build overlays/monitoring-istio-permissive > monitoring-istio-perm.yaml
	kubectl apply -f monitoring-istio-perm.yaml

## Remove monitoring-istio-perm overlay
remove-monitoring-istio-perm-app:
	kubectl delete -f monitoring-istio-perm.yaml


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
