docker tag kursovik_ui daniilrostov/ui:1.0
docker tag kursovik_crawler daniilrostov/crawler:1.0
docker tag kursovik_prometheus daniilrostov/prometheus:1.0
docker tag kursovik_grafana daniilrostov/grafana:1.0
docker push daniilrostov/ui:1.0
docker push daniilrostov/crawler:1.0
docker push daniilrostov/prometheus:1.0
docker push daniilrostov/grafana:1.0
kubectl create namespace prod --kubeconfig=/opt/kubeconfig
kubectl delete -f ./kubernetes/mongo-deployment.yml -n prod --kubeconfig=/opt/kubeconfig
kubectl delete -f ./kubernetes/mongo-service.yml -n prod --kubeconfig=/opt/kubeconfig
kubectl delete -f ./kubernetes/rabbitmq-deployment.yml -n prod --kubeconfig=/opt/kubeconfig
kubectl delete -f ./kubernetes/rabbitmq-service.yml -n prod --kubeconfig=/opt/kubeconfig
IMAGE_TAG=1.0 envsubst < ./kubernetes/crawler-deployment.yml | kubectl delete -f - -n prod --kubeconfig=/opt/kubeconfig
kubectl delete -f ./kubernetes/crawler-service.yml -n prod --kubeconfig=/opt/kubeconfig
IMAGE_TAG=1.0 envsubst < ./kubernetes/ui-deployment.yml | kubectl delete -f - -n prod --kubeconfig=/opt/kubeconfig
kubectl delete -f ./kubernetes/ui-service.yml -n prod --kubeconfig=/opt/kubeconfig
kubectl delete -f ./kubernetes/ingress-prod.yml -n prod --kubeconfig=/opt/kubeconfig
kubectl delete -f ./kubernetes/ingress-prometheus-prod.yml -n prod --kubeconfig=/opt/kubeconfig
IMAGE_TAG=1.0 envsubst < ./kubernetes/prometheus-deployment.yml | kubectl delete -f - -n prod --kubeconfig=/opt/kubeconfig
kubectl delete -f ./kubernetes/prometheus-service.yml -n prod --kubeconfig=/opt/kubeconfig
IMAGE_TAG=1.0 envsubst < ./kubernetes/grafana-deployment.yml | kubectl delete -f - -n prod --kubeconfig=/opt/kubeconfig
kubectl delete -f ./kubernetes/grafana-service.yml -n prod --kubeconfig=/opt/kubeconfig
kubectl apply -f ./kubernetes/mongo-deployment.yml -n prod --kubeconfig=/opt/kubeconfig
kubectl apply -f ./kubernetes/mongo-service.yml -n prod --kubeconfig=/opt/kubeconfig
kubectl apply -f ./kubernetes/rabbitmq-deployment.yml -n prod --kubeconfig=/opt/kubeconfig
kubectl apply -f ./kubernetes/rabbitmq-service.yml -n prod --kubeconfig=/opt/kubeconfig
IMAGE_TAG=1.0 envsubst < ./kubernetes/crawler-deployment.yml | kubectl apply -f - -n prod --kubeconfig=/opt/kubeconfig
kubectl apply -f ./kubernetes/crawler-service.yml -n prod --kubeconfig=/opt/kubeconfig
IMAGE_TAG=1.0 envsubst < ./kubernetes/ui-deployment.yml | kubectl apply -f - -n prod --kubeconfig=/opt/kubeconfig
kubectl apply -f ./kubernetes/ui-service.yml -n prod --kubeconfig=/opt/kubeconfig
kubectl apply -f ./kubernetes/ingress-prod.yml -n prod --kubeconfig=/opt/kubeconfig
kubectl apply -f ./kubernetes/ingress-prometheus-prod.yml -n prod --kubeconfig=/opt/kubeconfig
IMAGE_TAG=1.0 envsubst < ./kubernetes/prometheus-deployment.yml | kubectl apply -f - -n prod --kubeconfig=/opt/kubeconfig
kubectl apply -f ./kubernetes/prometheus-service.yml -n prod --kubeconfig=/opt/kubeconfig
IMAGE_TAG=1.0 envsubst < ./kubernetes/grafana-deployment.yml | kubectl apply -f - -n prod --kubeconfig=/opt/kubeconfig
kubectl apply -f ./kubernetes/grafana-service.yml -n prod --kubeconfig=/opt/kubeconfig
