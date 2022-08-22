docker tag kursovik_ui daniilrostov/ui:1.0
docker tag kursovik_crawler daniilrostov/crawler:1.0
docker tag kursovik_prometheus daniilrostov/prometheus:1.0
docker tag kursovik_grafana daniilrostov/grafana:1.0
docker push daniilrostov/ui:1.0
docker push daniilrostov/crawler:1.0
docker push daniilrostov/prometheus:1.0
docker push daniilrostov/grafana:1.0
kubectl apply -f ./kubernetes/mongo-deployment.yml --kubeconfig=/opt/kubeconfig
kubectl apply -f ./kubernetes/mongo-service.yml --kubeconfig=/opt/kubeconfig
kubectl apply -f ./kubernetes/rabbitmq-deployment.yml --kubeconfig=/opt/kubeconfig
kubectl apply -f ./kubernetes/rabbitmq-service.yml --kubeconfig=/opt/kubeconfig
kubectl apply -f ./kubernetes/crawler-deployment.yml --kubeconfig=/opt/kubeconfig
kubectl apply -f ./kubernetes/crawler-service.yml --kubeconfig=/opt/kubeconfig
kubectl apply -f ./kubernetes/ui-deployment.yml --kubeconfig=/opt/kubeconfig
kubectl apply -f ./kubernetes/ui-service.yml --kubeconfig=/opt/kubeconfig
kubectl apply -f ./kubernetes/ingress.yml --kubeconfig=/opt/kubeconfig
kubectl apply -f ./kubernetes/ingress-prometheus.yml --kubeconfig=/opt/kubeconfig
kubectl apply -f ./kubernetes/prometheus-deployment.yml --kubeconfig=/opt/kubeconfig
kubectl apply -f ./kubernetes/prometheus-service.yml --kubeconfig=/opt/kubeconfig
kubectl apply -f ./kubernetes/grafana-deployment.yml --kubeconfig=/opt/kubeconfig
kubectl apply -f ./kubernetes/grafana-service.yml --kubeconfig=/opt/kubeconfig