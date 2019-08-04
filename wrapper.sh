# Create GCP Kubernetes Cluster by passing the Project ID as a parameter

PROJECT_ID=$1
cd terraform

echo "===Running terraform to create the GCP K8s cluster under the $PROJECT_ID project==="
echo "yes" | terraform apply -var="project_id=$PROJECT_ID"

cd ../guestbook

echo "==========Getting the K8s configuration=========="
gcloud container clusters get-credentials mstakx-cluster --zone asia-south1-a --project $PROJECT_ID

echo "==========Creating Namespaces=========="
kubectl apply -f namespace.yml

echo "==========Creating Ingress=========="
kubectl apply -f ingress/

echo "==========Creating Staging Environment=========="
kubectl apply -f staging/

echo "==========Creating Production Environment=========="
kubectl apply -f production/