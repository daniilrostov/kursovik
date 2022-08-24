docker tag kursovik_ui daniilrostov/ui:latest
docker tag kursovik_crawler daniilrostov/crawler:latest
docker tag kursovik_prometheus daniilrostov/prometheus:latest
docker tag kursovik_grafana daniilrostov/grafana:latest
docker push daniilrostov/ui:latest
docker push daniilrostov/crawler:latest
docker push daniilrostov/prometheus:latest
docker push daniilrostov/grafana:latest
kubectl create namespace dev --kubeconfig=/opt/kubeconfig
kubectl delete -f ./kubernetes/mongo-deployment.yml -n dev --kubeconfig=/opt/kubeconfig
kubectl delete -f ./kubernetes/mongo-service.yml -n dev --kubeconfig=/opt/kubeconfig
kubectl delete -f ./kubernetes/rabbitmq-deployment.yml -n dev --kubeconfig=/opt/kubeconfig
kubectl delete -f ./kubernetes/rabbitmq-service.yml -n dev --kubeconfig=/opt/kubeconfig
kubectl delete -f ./kubernetes/crawler-deployment.yml -n dev --kubeconfig=/opt/kubeconfig
kubectl delete -f ./kubernetes/crawler-service.yml -n dev --kubeconfig=/opt/kubeconfig
kubectl delete -f ./kubernetes/ui-deployment.yml -n dev --kubeconfig=/opt/kubeconfig
kubectl delete -f ./kubernetes/ui-service.yml -n dev --kubeconfig=/opt/kubeconfig
kubectl delete -f ./kubernetes/ingress-dev.yml -n dev --kubeconfig=/opt/kubeconfig
kubectl delete -f ./kubernetes/ingress-prometheus-dev.yml -n dev --kubeconfig=/opt/kubeconfig
kubectl delete -f ./kubernetes/prometheus-deployment.yml -n dev --kubeconfig=/opt/kubeconfig
kubectl delete -f ./kubernetes/prometheus-service.yml -n dev --kubeconfig=/opt/kubeconfig
kubectl delete -f ./kubernetes/grafana-deployment.yml -n dev --kubeconfig=/opt/kubeconfig
kubectl delete -f ./kubernetes/grafana-service.yml -n dev --kubeconfig=/opt/kubeconfig
kubectl apply -f ./kubernetes/mongo-deployment.yml -n dev --kubeconfig=/opt/kubeconfig
kubectl apply -f ./kubernetes/mongo-service.yml -n dev --kubeconfig=/opt/kubeconfig
kubectl apply -f ./kubernetes/rabbitmq-deployment.yml -n dev --kubeconfig=/opt/kubeconfig
kubectl apply -f ./kubernetes/rabbitmq-service.yml -n dev --kubeconfig=/opt/kubeconfig
kubectl apply -f ./kubernetes/crawler-deployment.yml -n dev --kubeconfig=/opt/kubeconfig
kubectl apply -f ./kubernetes/crawler-service.yml -n dev --kubeconfig=/opt/kubeconfig
kubectl apply -f ./kubernetes/ui-deployment.yml -n dev --kubeconfig=/opt/kubeconfig
kubectl apply -f ./kubernetes/ui-service.yml -n dev --kubeconfig=/opt/kubeconfig
kubectl apply -f ./kubernetes/ingress-dev.yml -n dev --kubeconfig=/opt/kubeconfig
kubectl apply -f ./kubernetes/ingress-prometheus-dev.yml -n dev --kubeconfig=/opt/kubeconfig
kubectl apply -f ./kubernetes/prometheus-deployment.yml -n dev --kubeconfig=/opt/kubeconfig
kubectl apply -f ./kubernetes/prometheus-service.yml -n dev --kubeconfig=/opt/kubeconfig
kubectl apply -f ./kubernetes/grafana-deployment.yml -n dev --kubeconfig=/opt/kubeconfig
kubectl apply -f ./kubernetes/grafana-service.yml -n dev --kubeconfig=/opt/kubeconfig