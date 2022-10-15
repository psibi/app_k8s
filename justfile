# List all recipies
default:
    just --list --unsorted

# Build app_ssl_nginx overlay
build-app:
    kustomize build overlays/app_ssl_nginx

# Apply app-ssl-nginx overlay
apply-app:
    kustomize build overlays/app_ssl_nginx > nginx_app.yaml
    kubectl apply -f nginx_app.yaml

# Remove app-ssl-nginx from the cluster
remove-app:
    kubectl delete -f nginx_app.yaml

# Check Kubernetse cluster
check:
    kubectl get nodes
