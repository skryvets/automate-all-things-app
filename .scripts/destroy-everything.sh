#!/usr/bin/env bash

# Destroy Everything Script
# This script is designed to tear down all the resources that were created
# by the 'deploy-everything.sh' script.

realpath() {
    [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}
ABSPATH=$(realpath $0)
BASEPATH=$(dirname ${ABSPATH})
PROJPATH=$(dirname ${BASEPATH})

# Step 1. Uninstall automate-all-things-app Helm Chart
echo "Uninstalling automate-all-things-app Helm Chart..."
helm uninstall automate-all-things-app -n automate-all-things-app

# Step 2. Deleting 'automate-all-things-app' namespace...
echo "Deleting 'automate-all-things-app' namespace..."
kubectl delete namespace automate-all-things-app

# Step 3. Uninstall ingress-nginx Helm Chart
echo "Uninstalling ingress-nginx Helm Chart..."
helm uninstall ingress-nginx -n ingress-nginx

# Step 4. Delete ingress-nginx Namespace
echo "Deleting 'ingress-nginx' namespace..."
kubectl delete namespace ingress-nginx

# This step should remove the LoadBalancer service associated with ingress-nginx
# thereby deallocating the AWS ELB that was created for the service.

# Step 5. Destroy AWS EKS Infrastructure with Terraform
echo "Destroying AWS EKS Infrastructure..."
terraform -chdir=terraform/aws-eks/ destroy -auto-approve

# Print completion message
echo "======================================="
echo "Resources have been successfully destroyed."
echo "======================================="
