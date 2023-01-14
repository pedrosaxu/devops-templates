#!/bin/bash

# Define variables for namespace and deployment name
namespace="test"
deployment_name="logstash_app"

# Define kubeconfig file path
kubeconfig_path="bamboo.conf"

echo "Getting deployments..."
./kubectl --kubeconfig=$kubeconfig_path get deployments --namespace=$namespace

echo "Restarting deployment..."
./kubectl --kubeconfig=$kubeconfig_path rollout restart deployment/$deployment_name --namespace=$namespace

echo "Waiting for pods to be ready..."
while true; do
  # Get the replicas number of the deployment
  replicas=$(./kubectl --kubeconfig=$kubeconfig_path get deployment $deployment_name --namespace=$namespace -o jsonpath='{.spec.replicas}')
  # Get the number of ready pods
  ready_pods=$(./kubectl --kubeconfig=$kubeconfig_path get pods --namespace=$namespace | grep $deployment_name | grep -c "Running")
  if [[ $ready_pods -eq $replicas ]]; then
    echo "All pods are ready."
    sleep 5
    break
  else
    echo "Waiting for pods to be ready..."
    sleep 5
  fi
done

echo "Getting deployments..."
./kubectl --kubeconfig=$kubeconfig_path get deployments --namespace=$namespace

## NEEDS WORK - DOES NOT WORK PROPERLY YET ##
# echo "Getting deployment status..."
# ./kubectl --kubeconfig=$kubeconfig_path rollout status deployment $deployment_name --namespace=$namespace

# echo "Getting deployment description..."
# ./kubectl --kubeconfig=$kubeconfig_path describe deployment $deployment_name --namespace=$namespace

# echo "Getting deployment history..."
# ./kubectl --kubeconfig=$kubeconfig_path rollout history deployment $deployment_name --namespace=$namespace