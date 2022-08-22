docker tag kursovik_ui daniilrostov/ui:latest
docker tag kursovik_crawler daniilrostov/crawler:latest
docker tag kursovik_prometheus daniilrostov/prometheus:latest
docker tag kursovik_grafana daniilrostov/grafana:latest
docker push daniilrostov/ui:latest
docker push daniilrostov/crawler:latest
docker push daniilrostov/prometheus:latest
docker push daniilrostov/grafana:latest
kubectl create namespace dev --kubeconfig=/opt/kubeconfig
kubectl apply -f ./kubernetes/mongo-deployment.yml --kubeconfig=/opt/kubeconfig -n dev --kubeconfig=/opt/kubeconfig
kubectl apply -f ./kubernetes/mongo-service.yml --kubeconfig=/opt/kubeconfig -n dev --kubeconfig=/opt/kubeconfig
kubectl apply -f ./kubernetes/rabbitmq-deployment.yml --kubeconfig=/opt/kubeconfig -n dev --kubeconfig=/opt/kubeconfig
kubectl apply -f ./kubernetes/rabbitmq-service.yml --kubeconfig=/opt/kubeconfig -n dev --kubeconfig=/opt/kubeconfig
kubectl apply -f ./kubernetes/crawler-deployment.yml --kubeconfig=/opt/kubeconfig -n dev --kubeconfig=/opt/kubeconfig
kubectl apply -f ./kubernetes/crawler-service.yml --kubeconfig=/opt/kubeconfig -n dev --kubeconfig=/opt/kubeconfig
kubectl apply -f ./kubernetes/ui-deployment.yml --kubeconfig=/opt/kubeconfig -n dev --kubeconfig=/opt/kubeconfig
kubectl apply -f ./kubernetes/ui-service.yml --kubeconfig=/opt/kubeconfig -n dev --kubeconfig=/opt/kubeconfig
kubectl apply -f ./kubernetes/ingress-dev.yml --kubeconfig=/opt/kubeconfig -n dev --kubeconfig=/opt/kubeconfig
kubectl apply -f ./kubernetes/ingress-prometheus-dev.yml --kubeconfig=/opt/kubeconfig -n dev --kubeconfig=/opt/kubeconfig
kubectl apply -f ./kubernetes/prometheus-deployment.yml --kubeconfig=/opt/kubeconfig -n dev --kubeconfig=/opt/kubeconfig
kubectl apply -f ./kubernetes/prometheus-service.yml --kubeconfig=/opt/kubeconfig -n dev --kubeconfig=/opt/kubeconfig
kubectl apply -f ./kubernetes/grafana-deployment.yml --kubeconfig=/opt/kubeconfig -n dev --kubeconfig=/opt/kubeconfig
kubectl apply -f ./kubernetes/grafana-service.yml --kubeconfig=/opt/kubeconfig -n dev --kubeconfig=/opt/kubeconfig
