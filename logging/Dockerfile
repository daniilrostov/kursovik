FROM fluent/fluentd:v1.12-debian
USER root
RUN ["gem", "install", "fluent-plugin-elasticsearch"]
RUN ["gem", "install", "fluent-plugin-input-gelf"]
USER fluent