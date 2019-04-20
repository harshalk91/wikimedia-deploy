sudo kubectl delete secret mysql-secret-test
sudo kubectl delete -f mysql-deployment.yaml
sudo kubectl delete -f wkmedia-deployment.yaml
sudo minikube stop
