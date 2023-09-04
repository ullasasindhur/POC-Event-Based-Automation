# Event Driven Ansible(EDA) setup:

## Prerequisites:
- [Kubernetes Cluster](https://github.com/ullasasindhur/kubernetes-learning/blob/main/setup/cluster/README.md)
- [helm](https://helm.sh/docs/intro/install/)

## Installation:
1. awx-operator installation.
    - Execute the following commands inside `eda-server` folder
        ```shell
        helm repo add awx-operator https://ansible.github.io/awx-operator/
        helm repo update
        helm install my-awx-operator awx-operator/awx-operator -n awx --create-namespace
        kubectl create -f local-storage-class.yaml -f pv.yaml -f pvc.yaml -f ansible-awx.yaml
        kubectl expose deployment ansible-awx-web --name ansible-awx-web-svc --type NodePort -n awx
        ```
        > Note: please make sure you have /mnt/storage folder present in kworker01 node.
    - You can get exposed port of service by executing the command `kubectl get svc ansible-awx-web-svc  -n awx`.
    - You can get the password by executing following command `kubectl get secret ansible-awx-admin-password -o jsonpath="{.data.password}" -n awx | base64 --decode`.
    - Open browser and enter ip/exposed_port in your browser and login with `username` as *admin* and password is the output of above command.
        > Note: please remove "%" at the end of the password output,if present. 
2. Creating a user token in AWX-Operator
    - Navigate to the Users page in the AWX UI
    - Select the username you wish to create a token for
    - Click on tokens, then the green plus icon
    - Application can be left empty, input a description and select the read/write scope.

## References:
- https://github.com/ansible/awx-operator
- https://www.linuxtechi.com/install-ansible-awx-on-kubernetes-cluster/