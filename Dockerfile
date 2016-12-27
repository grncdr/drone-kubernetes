FROM lachlanevenson/k8s-kubectl:v1.5.1

RUN apk update && apk --no-cache add jq
ADD make-shell-script.jq /make-shell-script.jq
ENTRYPOINT ["./deploy.sh"]
