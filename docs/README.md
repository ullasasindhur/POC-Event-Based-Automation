# POC: Event Based Automation

## Setup
1. To setup Zabbix, Please refer this [link](/setup/zabbix/README.md).
2. TO setup Ansible Automation Platform, please refer this [link](/setup/ansible-automation-platform/README.md).
3. To Configure Kubernetes-Monitor with zabbix, please refer this [link](/setup/kubernetes-monitor/README.md).

## Working:
- Event Driven Ansible contains a Decision Environments, in which Rulebooks are executed, rulebooks are the crucial part of Event Driven Ansible written in YAML just like ansible playbooks,contains four main parts; Name,hosts, Sources, Rules.
- Sources are like triggers/events sources which initiate the rulebook, which checks the conditions in the rules defined, executes action inside rules upon satisfaction of condition.

### Rulebook-Examples:
1. Rulebook using range as source and executing debug action
    ```YAML
    - name: Example
    hosts: all
    sources:
        - name: range
        range:
            limit: 5
    rules:
        - name: r1
        condition: event.i == 1
        action:
            debug:

        - name: "Host specific rule"
        condition:
            all:
            - fact.ansible_os_family == "linux"
            - fact.meta.hosts == "my-host"
            - event.i == 4
        action:
            debug:
    ```
2. Rulebook using alerts manager as source and executing playbook action
    ```yaml
    ---
    - name: Automatic Remediation of a webserver
    hosts: all
    sources:
        - name: listen for alerts
        ansible.eda.alertmanager:
            host: 0.0.0.0
            port: 8000
    rules:
        - name: restart web server
        condition: event.alert.labels.job == "fastapi" and event.alert.status == "firing"
        action:
            run_playbook:
            name: ansible.eda.start_app
    ```
3. Rulebook using webhook as source and executing playbook action
    ```yaml
    ---
    - name: Listen for events on a webhook
    hosts: all

    ## Define our source for events

    sources:
        - ansible.eda.webhook:
            host: 0.0.0.0
            port: 5000

    ## Define the conditions we are looking for

    rules:
        - name: Say Hello
        condition: event.payload.message == "Ansible is super cool"

    ## Define the action we should take should the condition be met

        action:
            run_playbook:
            name: say-what.yml
    ```


## Use-Cases:
- Able to resolve general issues like Scaling Up/Down of resources.
- Able to check server status, bringing server up if it is down.
- Able to handle alerts from sources like kafka, azure service bus, alertsmanager and webhook.

### Event Sources:
- Alertsmanager
- Azure Service Bus
- kafka
- URL Check
- Watchdog
- Webhook
- Tick
- File
- Range

### Actions:
- Run Playbook
- Run Module
- Run Job Template
- Run Workflow Template
- Set Fact
- Post Event
- Retract Fact
- Print Event
- Shutdown
- Debug
- None

## Zabbix:
### Setup:
- Need to add items, Triggers and Events according to requirements.
- Enable EDA media type.
- Add media to the required Users which endpoint url of ansible-rulebook.
- Add action->event-actions as per requirements.

## Technologies/Tools:
- Zabbix
- Ansible Automation Platform/Event Driven Ansible

## References:
- [Zabbix Config](https://www.zabbix.com/documentation/current/en/manual/config)
- [Ansible Rulebooks](https://ansible.readthedocs.io/projects/rulebook/en/stable/rulebooks.html)
- [Ansible Rulebook Rules](https://ansible.readthedocs.io/projects/rulebook/en/stable/rules.html)
- [Ansible Rulebook Conditions](https://ansible.readthedocs.io/projects/rulebook/en/stable/conditions.html)
- [Ansible Rulebook Actions](https://ansible.readthedocs.io/projects/rulebook/en/stable/actions.html)