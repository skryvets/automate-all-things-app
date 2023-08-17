# Automate All Things App

## Description

Automate All Things App is an example application designed to demonstrate a complete DevOps pipeline. It includes a backend service and other essential components. The application is deployed using Kubernetes and is managed with Terraform. This example showcases:

- Automated testing to ensure code quality and functionality
- Fully automated deployment to a cloud environment (in this case, AWS, using EKS for Kubernetes)
- Infrastructure as Code (IAC) using Terraform for reliable and repeatable infrastructure deployments

## Prerequisites

- AWS CLI installed and configured with appropriate permissions
- Terraform
- kubectl
- Helm (version >= 3)
- Git

## Quickstart

Clone the repository and navigate to the project directory:

```bash
git clone https://github.com/yourusername/automate-all-things-app.git
cd automate-all-things-app
```

### Environment Setup

To launch the environment, run the following command. This script sets up the necessary resources in AWS using Terraform, deploys a Kubernetes cluster using EKS, and installs the application via Helm:

```bash
.scripts/deploy-everything.sh
```

### Application Access

After running the script, the LoadBalancer Address for accessing the application will be printed in the console output:

```plaintext
=======================================
LoadBalancer Address: <Load_Balancer_IP_Address>
=======================================
```

You can access the application at:

```
http://<Load_Balancer_IP_Address>
```

### Environment Tear Down

To tear down the environment, run the following script:

```bash
.scripts/destroy-everything.sh
```

## Automated Tests

To validate the environment, run the following command:

```bash
# Example: Replace with your test command
./gradlew test
```

## Notes and Assumptions

- This setup assumes you have already configured your AWS CLI with the necessary credentials.
- The Terraform scripts are set to deploy resources in the `us-west-2` region by default. Update the Terraform variables if a different region is desired.