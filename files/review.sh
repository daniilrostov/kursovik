docker tag kursovik_ui daniilrostov/ui:latest
docker tag kursovik_crawler daniilrostov/crawler:latest
docker tag kursovik_prometheus daniilrostov/prometheus:latest
docker tag kursovik_grafana daniilrostov/grafana:latest
docker push daniilrostov/ui:latest
docker push daniilrostov/crawler:latest
docker push daniilrostov/prometheus:latest
docker push daniilrostov/grafana:latest