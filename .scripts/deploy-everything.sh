#!/usr/bin/env bash

realpath() {
    [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}
ABSPATH=$(realpath $0)
BASEPATH=$(dirname ${ABSPATH})
PROJPATH=$(dirname ${BASEPATH})

# Step 1: Apply Terraform
terraform -chdir=terraform/aws-eks/ apply -auto-approve

# Step 2: Extract Outputs from Terraform
cluster_name=$(terraform -chdir=terraform/aws-eks/ output -raw cluster_name)
region=$(terraform -chdir=terraform/aws-eks/ output -raw region)

# Step 3: Update Kubeconfig for EKS Cluster
aws eks update-kubeconfig --region $region --name $cluster_name

# Log Statements: Print the Cluster Name and Region
echo "======================================="
echo "Cluster Name: $cluster_name"
echo "Region:       $region"
echo "======================================="

# Step 4: Print Current Context
current_context=$(kubectl config current-context)
echo "Current Context: $current_context"

# Step 5: Print Cluster Information
echo "Cluster Information:"
kubectl cluster-info

# Step 6: Print Nodes Information
echo "Nodes Information:"
kubectl get nodes

# Step 7: Install ingress-nginx Helm Chart
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm install ingress-nginx ingress-nginx/ingress-nginx -n ingress-nginx --create-namespace

# Step 7.1: Waiting for LoadBalancer to be provisioned...
echo "Waiting for LoadBalancer to be provisioned..."
while [ -z $loadbalancer_address ]; do
  sleep 10
  loadbalancer_address=$(kubectl get svc ingress-nginx-controller -n ingress-nginx --template "{{ range (index .status.loadBalancer.ingress 0) }}{{.}}{{ end }}")
  echo "Checking for LoadBalancer address..."
done

# Step 8: Install automate-all-things-app
helm install automate-all-things-app ./k8s/helm-chart/automate-all-things-app -n automate-all-things-app --create-namespace --set ingress.host=$loadbalancer_address

echo "======================================="
echo "LoadBalancer Address: $loadbalancer_address"
echo "======================================="