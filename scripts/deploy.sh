#!/bin/bash
# Deploying Secrets
echo "Starting minikube..Be patient..."
sudo minikube start --vm-driver=none
echo "==================================================="
echo "Checking Node status"

node_status=$(sudo kubectl get nodes | grep minikube | awk '{print $2}')

while [ "$node_status" != "Ready" ]
do
	sleep 2
        node_status=$(sudo kubectl get nodes | grep minikube | awk '{print $2}')
	echo "Kubernetes Node status: $node_status" 
done

echo "==================================================="
# base64 passwords
username=$(echo cm9vdAo= | base64 --decode)
password=$(echo V3h0YmU3NXBvTkUK | base64 --decode)
database=$(echo bWVkaWF3aWtpCg== | base64 --decode) 

echo "Creating Secrets"
sudo kubectl create secret generic mysql-secret-test --from-literal=username=$username --from-literal=password=$password --from-literal=database=$database

echo "==================================================="
echo "Deploying Mysql"
sudo kubectl apply -f ../conf/mysql-deployment.yaml 

pod_status=$(sudo kubectl get pods | grep mysql | awk '{print $3}')
while [ "$pod_status" != "Running" ]
do 
	sleep 2
	pod_status=$(sudo kubectl get pods | grep mysql | awk '{print $3}')
	echo "Pod Status: $pod_status"
done
#pod_name=$(sudo kubectl get pods | grep mysql | awk '{print $1}')

sleep 15

echo "==================================================="
#sudo kubectl exec -i $pod_name -- mysql -u $username -p$password $database < create_user.sql
echo "Granting privilleges"
sudo kubectl exec -i $(sudo kubectl get pods | grep mysql | awk '{print $1}') -- mysql -u$username -p$password < create_user.sql

echo "==================================================="
echo "Deploying wikimedia application"

sudo kubectl apply -f ../conf/wkmedia-deployment.yaml

while true
do
	deployment_replicas=`sudo kubectl get deployment | grep wkmedia | awk '{print $4}'`
	if (( $deployment_replicas >= 1 ))
	 then
	     echo "$deployment_replicas"
	     break
         fi
done
echo "========================================"
echo "Local Access Wikimedia using: `sudo minikube service wkmedia --url`"
echo "Global Access Wikimedia using: http://`curl -s icanhazip.com`:30080"
echo "========================================"
