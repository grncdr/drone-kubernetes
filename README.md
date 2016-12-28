# drone-kubernetes-deploy

Worlds simplest kubernetes deploy plugin for Drone CI.

## How to deploy to kubernetes

1. Somewhere in your build, produce files suitable for `kubectl apply -f
   $file`, e.g. a file named `/drone/kubernetes.yml`.
2. Configure secrets containing the necessary authentication data.
3. Add something like this to `.drone.yml`:

   ```yaml
   deploy:
     kubernetes:
       image: grncdr/drone-kubernetes
       api_server: https://kubernetes.mycluster.com
       certificate_authority_data: "$$KUBECTL_CA_CERT"
       client_certificate_data: "$$KUBECTL_CLIENT_CERT"
       client_key_data: "$$KUBECTL_CLIENT_KEY"
       resource_file: /drone/kubernetes.yml
   ```
4. That's it.
