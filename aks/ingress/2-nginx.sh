#!/bin/bash

# Add the ingress-nginx repository
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

# Set variable for ACR location to use for pulling images
ACR_LOGIN_SERVER=rachercr.azurecr.io

# from reddit
# https://www.reddit.com/r/kubernetes/comments/pksgk4/problem_installing_ingressnginx_on_aks_via_helm/
# CONTROLLER_REGISTRY=k8s.gcr.io
# CONTROLLER_IMAGE=ingress-nginx/controller
# CONTROLLER_TAG=v0.48.1
# # PATCH_REGISTRY=docker.io
# PATCH_IMAGE=jettech/kube-webhook-certgen
# PATCH_TAG=v1.10.0
# # DEFAULTBACKEND_REGISTRY=k8s.gcr.io
# DEFAULTBACKEND_IMAGE=defaultbackend-amd64
# DEFAULTBACKEND_TAG=1.5

CONTROLLER_IMAGE=ingress-nginx/controller
CONTROLLER_TAG=v1.8.1
# PATCH_REGISTRY=docker.io
PATCH_IMAGE=ingress-nginx/kube-webhook-certgen
PATCH_TAG=v20230407
# DEFAULTBACKEND_REGISTRY=k8s.gcr.io
DEFAULTBACKEND_IMAGE=defaultbackend-amd64
DEFAULTBACKEND_TAG=1.5


# from github issue
# https://github.com/MicrosoftDocs/azure-docs/issues/93934
# helm install cert-manager jetstack/cert-manager \
#   --namespace ingress-basic \
#   --version $CERT_MANAGER_TAG \
#   --set installCRDs=true

# Use Helm to deploy an NGINX ingress controller
helm install ingress-nginx ingress-nginx/ingress-nginx \
		--debug \
    --version 4.7.1 \
    --namespace ingress-basic \
    --create-namespace \
    --set controller.replicaCount=2 \
    --set controller.nodeSelector."kubernetes\.io/os"=linux \
    --set controller.image.registry=$ACR_LOGIN_SERVER \
    --set controller.image.image=$CONTROLLER_IMAGE \
    --set controller.image.tag=$CONTROLLER_TAG \
    --set controller.image.digest="" \
    --set controller.admissionWebhooks.patch.nodeSelector."kubernetes\.io/os"=linux \
    --set controller.service.annotations."service\.beta\.kubernetes\.io/azure-load-balancer-health-probe-request-path"=/healthz \
    --set controller.service.externalTrafficPolicy=Local \
    --set controller.admissionWebhooks.patch.image.registry=$ACR_LOGIN_SERVER \
    --set controller.admissionWebhooks.patch.image.image=$PATCH_IMAGE \
    --set controller.admissionWebhooks.patch.image.tag=$PATCH_TAG \
    --set controller.admissionWebhooks.patch.image.digest="" \
    --set defaultBackend.nodeSelector."kubernetes\.io/os"=linux \
    --set defaultBackend.image.registry=$ACR_LOGIN_SERVER \
    --set defaultBackend.image.image=$DEFAULTBACKEND_IMAGE \
    --set defaultBackend.image.tag=$DEFAULTBACKEND_TAG \
    --set defaultBackend.image.digest=""
