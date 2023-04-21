# List all recipies
default:
    just --list --unsorted

# Build base kustomization
build-base:
    kustomize build base

# Build base-app kustomization
build-base-app:
    kustomize build overlays/basic_app

# Apply base-app to cluster
apply-base-app:
    kubectl apply -k overlays/basic_app

# Remove base-app from the cluster
remove-base-app:
    kubectl delete -k overlays/basic_app

# Build base-internal-app kustomization
build-base-internal-app:
    kustomize build overlays/basic_app_internal

# Apply base-internal-app to cluster
apply-base-internal-app:
    kustomize build overlays/basic_app_internal > internal.yaml
    kubectl apply -f  internal.yaml

# Remove base-internal-app from the cluster
remove-base-internal-app:
    kubectl delete -f internal.yaml

# Build base-internal-app-pv kustomization
build-base-internal-app-pv:
    kustomize build overlays/basic_app_internal_pv

# Apply base-internal-app-pv to cluster
apply-base-internal-app-pv:
    kustomize build overlays/basic_app_internal_pv > internal.yaml
    kubectl apply -f  internal.yaml

# Remove base-internal-app-pv from the cluster
remove-base-internal-app-pv:
    kubectl delete -f internal.yaml

# Build basic-nginx-app kustomization
build-basic-nginx-app:
    kustomize build overlays/app_nginx

# Apply basic-nginx-app to cluster
apply-basic-nginx-app:
    kustomize build overlays/app_nginx > nginx_app.yaml # Need this workaround because of upstream issue: https://github.com/kubernetes-sigs/kustomize/issues/1373#issuecomment-618439078
    kubectl apply -f nginx_app.yaml

# Remove basic-nginx-app from the cluster
remove-basic-nginx-app:
    kubectl delete -f nginx_app.yaml

# Build app_self_ssl_nginx overlay
build-self-nginx-app:
    kustomize build overlays/app_self_ssl_nginx

# Build app_self_ssl_nginx overlay
apply-self-nginx-app:
    kustomize build overlays/app_self_ssl_nginx > nginx_app.yaml
    kubectl apply -f nginx_app.yaml

# Remove basic-nginx-app from the cluster
remove-self-nginx-app:
    kubectl delete -f nginx_app.yaml

# Build app-secret-nginx overlay
build-app-secret-nginx:
    kustomize build overlays/app_secrets_nginx

# Build app-secret-nginx overlay
apply-app-secret-nginx:
    kustomize build overlays/app_secrets_nginx > nginx_app.yaml
    kubectl apply -f nginx_app.yaml

# Remove app-secret-nginx from the cluster
remove-app-secret-nginx:
    kubectl delete -f nginx_app.yaml

# Build app_ssl_nginx overlay
build-app-ssl-nginx:
    kustomize build overlays/app_ssl_nginx

# Apply app-ssl-nginx overlay
apply-app-ssl-nginx:
    kustomize build overlays/app_ssl_nginx > nginx_app.yaml
    kubectl apply -f nginx_app.yaml

# Remove app-ssl-nginx from the cluster
remove-app-ssl-nginx:
    kubectl delete -f nginx_app.yaml

# Build istio overlay
build-istio-app:
    kustomize build overlays/istio

# Apply istio overlay
apply-istio-app:
    kustomize build overlays/istio > istio.yaml
    kubectl apply -f istio.yaml
    kubectl apply -f overlays/istio/certificate.yaml

# Remove istio overlay
remove-istio-app:
    kubectl delete -f istio.yaml
    kubectl delete -f overlays/istio/certificate.yaml
    kubectl delete secret/httpbin-ingress-cert -n istio-system

# Build monitoring overlay
build-monitoring-app:
    kustomize build overlays/monitoring

# Apply monitoring overlay
apply-monitoring-app:
    kustomize build overlays/monitoring > monitoring.yaml
    kubectl apply -f monitoring.yaml

# Remove monitoring overlay
remove-monitoring-app:
    kubectl delete -f monitoring.yaml

# Build monitoring-istio overlay
build-monitoring-istio-app:
    kustomize build overlays/monitoring-istio

# Apply monitoring-istio overlay
apply-monitoring-istio-app:
    kustomize build overlays/monitoring-istio > monitoring-istio.yaml
    kubectl apply -f monitoring-istio.yaml

# Remove monitoring-istio overlay
remove-monitoring-istio-app:
    kubectl delete -f monitoring-istio.yaml

# Build istio-k8s-ingress overlay
build-istio-k8s-ingress-app:
    kustomize build overlays/istio_k8s_ingress

# Apply istio-k8s-ingress overlay
apply-istio-k8s-ingress-app:
    kustomize build overlays/istio_k8s_ingress > istio.yaml
    kubectl apply -f overlays/istio_k8s_ingress/certificate.yaml
    kubectl apply -f istio.yaml

# Remove istio-k8s-ingress overlay
remove-istio-k8s-ingress-app:
    kubectl delete -f istio.yaml

# Build app-internal-istio overlay
build-app-internal-istio:
    kustomize build overlays/app_internal_istio

# Apply app-internal-istio overlay
apply-app-internal-istio:
    kustomize build overlays/app_internal_istio > istio.yaml
    kubectl apply -f istio.yaml

# Remove app-internal-istio overlay
remove-app-internal-istio:
    kubectl delete -f istio.yaml

# Build istio-websocket overlay
build-istio-websocket:
    kustomize build overlays/websockets

# Apply istio-websocket overlay
apply-istio-websocket:
    kustomize build overlays/websockets > ws.yaml
    kubectl apply -f overlays/websockets/certificate.yaml
    kubectl apply -f ws.yaml

# Remove istio-websocket overlay
remove-istio-websocket:
    kubectl delete -f overlays/websockets/certificate.yaml
    kubectl delete -f ws.yaml

# Build app-internal-nginx overlay
build-app-internal-nginx:
    kustomize build overlays/app_internal_nginx

# Apply app-internal-nginx overlay
apply-app-internal-nginx:
    kustomize build overlays/app_internal_nginx > internal_nginx.yaml
    kubectl apply -f internal_nginx.yaml

# Remove app-internal-nginx overlay
remove-app-internal-nginx:
    kubectl delete -f internal_nginx.yaml

# Build istio-canary overlay
build-istio-canary:
    kustomize build overlays/istio_canary

# Apply istio-canary overlay
apply-istio-canary:
    kustomize build overlays/istio_canary > istio.yaml
    kubectl apply -f istio.yaml
    kubectl apply -f overlays/istio_canary/certificate.yaml

# Remove istio-canary overlay
remove-istio-canary-app:
    kubectl delete -f istio.yaml
    kubectl delete -f overlays/istio_canary/certificate.yaml
    kubectl delete secret/httpbin-ingress-cert -n istio-system

# Build nginx-canary overlay
build-nginx-canary:
    kustomize build overlays/nginx_canary

# Apply nginx-canary overlay
apply-nginx-canary:
    kustomize build overlays/nginx_canary > nginx_canary.yaml
    kubectl apply -f nginx_canary.yaml

# Remove nginx-canary overlay
remove-nginx-canary-app:
    kubectl delete -f nginx_canary.yaml

# Build argo-rollouts-nginx-canary overlay
build-argo-rollouts-nginx-canary:
    kustomize build overlays/argo_rollouts_nginx_canary

# Apply argo-rollouts-nginx-canary overlay
apply-argo-rollouts-nginx-canary:
    kustomize build overlays/argo_rollouts_nginx_canary > argo-rollouts-nginx_canary.yaml
    kubectl apply -f argo-rollouts-nginx_canary.yaml

# Remove argo-rollouts-nginx-canary overlay
remove-argo-rollouts-nginx-canary-app:
    kubectl delete -f argo-rollouts-nginx_canary.yaml

# Build argo-rollouts-nginx-canary_v2 overlay
build-argo-rollouts-nginx-canary_v2:
    kustomize build overlays/argo_rollouts_nginx_canary_v2

# Apply argo-rollouts-nginx-canary_v2 overlay
apply-argo-rollouts-nginx-canary_v2:
    kustomize build overlays/argo_rollouts_nginx_canary_v2 > argo-rollouts-nginx_canary.yaml
    kubectl apply -f argo-rollouts-nginx_canary.yaml

# Remove argo-rollouts-nginx-canary_v2 overlay
remove-argo-rollouts-nginx-canary_v2:
    kubectl delete -f argo-rollouts-nginx_canary.yaml

# Build argo-rollouts-nginx-analysis-analysis overlay
build-argo-rollouts-nginx-analysis:
    kustomize build overlays/argo_rollouts_nginx_analysis

# Apply argo-rollouts-nginx-analysis-analysis overlay
apply-argo-rollouts-nginx-analysis:
    kustomize build overlays/argo_rollouts_nginx_analysis > argo-rollouts-nginx-analysis_analysis.yaml
    kubectl apply -f argo-rollouts-nginx-analysis_analysis.yaml

# Remove argo-rollouts-nginx-analysis-analysis overlay
remove-argo-rollouts-nginx-analysis:
    kubectl delete -f argo-rollouts-nginx-analysis_analysis.yaml

# Build php app
build-php-app:
    kustomize build php_app

# Apply php app
apply-php-app:
    kustomize build php_app > php_app.yaml
    kubectl apply -f php_app.yaml

# Remove php app
remove-php-app:
    kubectl delete -f php_app.yaml

# Build php mixed app
build-php-mixed-app:
    kustomize build php_app_mixed

# Apply php mixed app
apply-php-mixed-app:
    kustomize build php_app_mixed > php_app_mixed.yaml
    kubectl apply -f php_app_mixed.yaml

# Remove php mixed app
remove-php-mixed-app:
    kubectl delete -f php_app_mixed.yaml

# Build NGINX blue green app
build-nginx-bg-app:
    kustomize build overlays/nginx_blue_green

# Apply NGINX blue green app
apply-nginx-bg-app:
    kustomize build overlays/nginx_blue_green > nginx_bg.yaml
    kubectl apply -f nginx_bg.yaml

# Remove NGINX blue green app
remove-nginx-bg-app:
    kubectl delete -f nginx_bg.yaml

# Build NGINX blue green app using rollouts
build-nginx-rbg-app:
    kustomize build overlays/nginx_rollout_blue_green

# Apply NGINX blue green app using rollouts
apply-nginx-rbg-app:
    kustomize build overlays/nginx_rollout_blue_green > nginx_rbg.yaml
    kubectl apply -f nginx_rbg.yaml

# Remove NGINX blue green app using rollouts
remove-nginx-rbg-app:
    kubectl delete -f nginx_rbg.yaml

# Check kubectl
check:
    kubectl get nodes
