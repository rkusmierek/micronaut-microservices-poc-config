argocd app create insurance-sales-portal \
  --repo https://github.com/rkusmierek/micronaut-microservices-poc-config \
  --path app/base \
  --dest-server https://kubernetes.default.svc \
  --dest-namespace insurance-sales-portal \
  --sync-policy automated
