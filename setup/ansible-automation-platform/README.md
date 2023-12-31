# Ansible Automation Platform Setup

## Prerequisites:
    - [Vagrant](https://developer.hashicorp.com/vagrant/downloads)
    - [Virtual Box](https://www.virtualbox.org/manual/ch02.html)
    - Redhat account
    
## Instructions:
    - Modify the settings.yaml file according to your requirements.
        > Note:  Please enter your download aap link,username and password of redhat subscription.
    - Run `vagrant up` command from `ansible-automation-platform` folder.
    - Edit the inventory file according to requirements and execute setup.sh file with sudo privilages
        > Note: Refer inventory_reference file

## Reference:
- [Watch this video](https://www.youtube.com/watch?v=q9TvvvfQzYE)

## Tips:
- If you are facing issue with ansible webhook communication, please disable firewalld with following commands
    ```shell
    sudo systemctl disable firewalld
    sudo service firewalld stop
    ```
- If you are getting error with Decision Environment, please disable the eth0 interface with following command
    ```shell
    sudo ifconfig eth0 down
    ```