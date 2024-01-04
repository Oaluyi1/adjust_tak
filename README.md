# The home_task

## Stack

- Python version: 3.9
- Web framework: Flask
- Libraries: Flask
- IDE: Visual Studio Code
- CI/CD: github and github actions
- Container management: Kubernetes/Minikube/Helm
- Code Analysis: Hadolint(Dockerfile) & Flake8 (Python Code)

## Solution

- The application uses Flask to create two endpoints:
  - `/hello`: Returns a JSON response with the message "Hello World" 
  - `/health`: Performs basic health checks and returns a JSON response with the application status.

## Decisions

- Flask was chosen for its simplicity and ease of use.
- The health check endpoint includes a basic check for debug mode.
- The Dockerfile uses a Python 3.9-slim base image for a smaller footprint.

### Additional Stack Decisions

- **IDE:**
  Visual Studio Code was chosen as the integrated development environment (IDE) for its lightweight design, excellent Python support, and a wide range of extensions.

- **CI/CD:**
  GitHub and GitHub Actions were selected for continuous integration and continuous deployment (CI/CD). GitHub Actions streamline the automation of workflows, such as linting, testing, and deployment, directly from the repository.

- **Container Management:**
  Kubernetes is employed for container management. Kubernetes provides orchestration and scalability, making it suitable for managing and deploying containerized applications.

- **Code Analysis:**
  - Hadolint is used for Dockerfile linting. It ensures best practices and consistency in Dockerfile construction.
  - Flake8 is utilized for Python code analysis. It checks for adherence to PEP 8 style guidelines and identifies potential errors and code smells.

These decisions were made to enhance the development and deployment processes, ensuring consistency, reliability, and ease of collaboration.

## Kubernetes Deployment

To deploy the application using Kubernetes, follow these steps:

### Local Kubernetes Solution

1. **Install Minikube:**
   If you don't have a Kubernetes cluster running locally, you can use Minikube. Install Minikube following the instructions at [https://minikube.sigs.k8s.io/docs/start/](https://minikube.sigs.k8s.io/docs/start/).

2. **Start Minikube:**
   Start Minikube to create a local Kubernetes cluster:
        ```bash
   minikube start
