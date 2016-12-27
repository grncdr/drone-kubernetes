# drone-kubernetes-deploy

Worlds simplest kubernetes deploy plugin for Drone CI.

## How to deploy to kubernetes

1. Somewhere in your build, produce files suitable for `kubectl apply -f
   $file`, e.g. a file named `/drone/deployment.yml`.
2. Add something like this to `.drone.yml`:
   ```yaml
   deploy:
     kubernetes:
       image: talon-one/drone-kubernetes-deploy
       volumes:
         - /path/to/kube-config-dir:/kubeconfig
       args:
         - "--kubeconfig=/kubeconfig/kubeconfig"
       resource_files:
         - /drone/kubernetes-deployment.yml
         - /drone/kubernetes-service.yml
   ```
3. That's it.
