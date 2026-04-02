terraform init

terraform plan 

terraform apply


terraform apply -auto-approve

cd terraform
terraform init   
terraform apply



# You can also port-forward the whole deployment without picking a pod:
kubectl port-forward deployment/nginx-deployment 8080:80 -n terraform-lab


# Get logs from the first pod it finds with the label app=nginx
kubectl logs -l app=nginx -n terraform-lab

# Enter the first pod it finds with the label app=nginx
kubectl exec -it $(kubectl get pods -n terraform-lab -l app=nginx -o name | head -n 1) -n terraform-lab -- /bin/bash
