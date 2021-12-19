#!/bin/bash

set -e

az login &> /dev/null

terraform -chdir=tf init
terraform -chdir=tf apply -auto-approve
echo "$(terraform -chdir=tf output -raw kube_config)" > ./tf/connect.yml

export KUBECONFIG=./tf/connect.yml

kubectl apply -f kubernetes

external_ip=""
while [ -z $external_ip ]; do
    sleep 10
    external_ip=$(kubectl get svc docker-rocket --template="{{range .status.loadBalancer.ingress}}{{.ip}}{{end}}")
done

echo "Chat address: $external_ip"

external_ip=""
while [ -z $external_ip ]; do
    sleep 10
    external_ip=$(kubectl get svc mongo-express-service --template="{{range .status.loadBalancer.ingress}}{{.ip}}{{end}}")
done

echo "Mongo express address: $external_ip"