# Monitoring Kuberentes with Zabbix:

## Prerequisites:
    - [Kubernetes Cluster](https://github.com/ullasasindhur/kubernetes-learning/blob/main/setup/cluster/README.md)
    - [helm](https://helm.sh/docs/intro/install/)
    - Network access between cluster and zabbix server.
## Setup:
1. Installing zabbix on kubernetes cluster.
    - from the kubernetes folder execute the following commands in terminal.
        ```shell
        helm repo add zabbix-chart-6.4  https://cdn.zabbix.com/zabbix/integrations/kubernetes-helm/6.4
        helm show values zabbix-chart-6.4/zabbix-helm-chrt > ./zabbix_values.yaml 
        kubectl create namespace zabbix
        helm install zabbix zabbix-chart-6.4/zabbix-helm-chrt --dependency-update -f ./zabbix_values.yaml -n zabbix
        kubectl get secret zabbix-service-account -n zabbix -o jsonpath={.data.token} | base64 -d 
        ```
2. Setting up proxy.
    - Open Zabbix portal and select `Administration` on left navigation bar and click on `proxies`.
    - click on `Create proxy` on right top, enter `Proxy name` as *zabbix-proxy* and click on Add.
3. Creating host groups.
    - Select `Data collection` from left navigation bar and click on `Host groups`.
    - Click on `Create host group` and enter `Group name` as *Kubernetes and click on Add.
4. Creating hosts for kuberneted nodes:
    - Select `Hosts` in the `Data collection` on left navigation bar.
    - Click on `Create host` and enter `Host Name` as *Kubernetes nodes*, `Templates` as *Kubernetes nodes by HTTP*, `Host groups` as *kubernetes*,`Monitored by proxy` to *zabbix-proxy*.
    - select `Macros` tab on popup top bar and click on `Inherited and host macros`.
    - Modify `{$KUBE.API.TOKEN}` value to token values generated at the end of Step-1.
        > Note: Please remove "%" at the end of the copied token,if present.
5. Creating hosts for kubernetes cluster state:
    - Click `Create hosts` again and enter `Host Name` as *Kubernetes Cluster State*, `Templates` as *Kubernetes cluster state by HTTP*, `Host groups` as *kubernetes*,`Monitored by proxy` to *zabbix-proxy*. 
       - select `Macros` tab on popup top bar and click on `Inherited and host macros`.
    - Modify `{$KUBE.API.TOKEN}` value to token values generated at the end of Step-1.
        > Note: Please remove "%" at the end of the copied token,if present.

## References:
- https://www.youtube.com/watch?v=Et2O2iyoCzI
- https://git.zabbix.com/projects/ZT/repos/kubernetes-helm/browse
- https://stackoverflow.com/questions/76818840/kubernetes-monitoring-using-zabbix
- You can check `zbx_export_hosts.yaml` which contains steps-3 to 5 by clicking directory on import
    > Note: Please modify token value

## Uninstall:
```
helm uninstall zabbix -n monitoring
```