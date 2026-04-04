minikube start

terraform init

terraform plan 

terraform apply


terraform apply -auto-approve

cd terraform
terraform init   
terraform apply

terraform destroy

# You can also port-forward the whole deployment without picking a pod:
kubectl port-forward deployment/nginx-deployment 8080:80 -n terraform-lab


kubectl logs -l app=nginx -n terraform-lab -f




# Get logs from the first pod it finds with the label app=nginx
kubectl logs -l app=nginx -n terraform-lab

# Enter the first pod it finds with the label app=nginx
kubectl exec -it $(kubectl get pods -n terraform-lab -l app=nginx -o name | head -n 1) -n terraform-lab -- /bin/bash


# Replace with one of your actual pod names
kubectl delete pod nginx-deployment-c845f45b5-fghpd -n terraform-lab


kubectl rollout restart deployment/nginx-deployment -n terraform-lab


kubectl get pods -n terraform-lab

kubectl get ns terraform-lab      





# 1. Point your terminal to Minikube's Docker engine
eval $(minikube docker-env)

# 2. Build using your specific filename
docker build -t my-custom-nginx:v1 -f Dockerfile.nginx .



minikube image ls --format table | grep my-custom-nginxs
eval $(minikube docker-env)

# 2. Build using your specific filename
docker build -t my-custom-nginx-1:v1 -f Dockerfile.nginx .



kubectl get pods -n terraform-lab -l app=jenkins -w


# This gives the Jenkins user permission to use the Docker socket
kubectl exec -it $(kubectl get pods -n terraform-lab -l app=jenkins -o name) -n terraform-lab -c jenkins -- su -c "chmod 666 /var/run/docker.sock" root

eval $(minikube docker-env) && docker ps


# get password
kubectl exec -it $JENKINS_POD -n terraform-lab -- cat /var/jenkins_home/secrets/initialAdminPassword



# ---------


# 1. Get the NEW pod name
JENKINS_POD=$(kubectl get pods -n terraform-lab -l app=jenkins -o jsonpath='{.items[0].metadata.name}')

# 2. Check the socket permissions WITHOUT the --user flag
kubectl exec -it $JENKINS_POD -n terraform-lab -- ls -l /var/run/docker.sock


# Update the internal package manager
kubectl exec -it $JENKINS_POD -n terraform-lab -- apt-get update

# Install the Docker CLI tool
kubectl exec -it $JENKINS_POD -n terraform-lab -- apt-get install -y docker.io


kubectl exec -it $JENKINS_POD -n terraform-lab -- docker --version


kubectl exec -it $JENKINS_POD -n terraform-lab -- curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
kubectl exec -it $JENKINS_POD -n terraform-lab -- chmod +x kubectl
kubectl exec -it $JENKINS_POD -n terraform-lab -- mv kubectl /usr/local/bin/



kubectl create rolebinding jenkins-admin-binding \
  --clusterrole=admin \
  --serviceaccount=terraform-lab:default \
  --namespace=terraform-lab
