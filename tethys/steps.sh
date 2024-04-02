TO TRY
- make sure that ingress is in correct namespace


1. create aks cluster
2. deploy postgres-config, postgres-static, postgres
3. deploy tethys
4. create load balancer in Azure GUI


good directions:
https://learn.microsoft.com/en-us/azure/aks/app-routing?tabs=default%2Cdeploy-app-default


bad directions:
https://learn.microsoft.com/en-us/azure/application-gateway/ingress-controller-expose-service-over-http-https


is the problem with Security Groups?
https://stackoverflow.com/questions/69133287/aks-load-balancer-ip-address-not-accessible


nginx keeps failing to start


with kubectl proxy:
http://localhost:8001/api/v1/namespaces/default/services/tethys:8000/proxy/


######
# Manually add ingress controller
https://kubernetes.github.io/ingress-nginx/deploy/#azure


#####
# Helm steps:
# NEVERMIND: lots of undefined variables - hits a timeout error
https://learn.microsoft.com/en-us/azure/aks/ingress-basic?tabs=azure-cli#create-an-ingress-controller
