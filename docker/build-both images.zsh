cd docker
eval $(minikube docker-env)

# Build App 1
docker build -t my-app:v1 -f Dockerfile.nginx .

# Build App 2
docker build -t my-app-1:v1 -f Dockerfile.nginx1 .
