Ansible Users SSH Access management:

Playbook role:
    push the standard sshd_config file to destination servers and restart the SSHD service.
    Add the users to denyssh group or allowssh group of linux OS based on the playbook call.

Requirements

Ansible Version : 2.7
It will work with: All Redhat and Centos

SSH users login management playbook:
The project used customized inventory, variable file and used the roles and tags methodology

ansible-playbook -i serverslist  sshmgmt.yml --extra-vars "hostgroup=DEV" 

You can use tags to call only grant task or deny task

ansible-playbook -i serverslist  sshmgmt.yml --extra-vars "hostgroup=DEV" --tags grant

ansible-playbook -i serverslist  sshmgmt.yml --extra-vars "hostgroup=DEV" --tags deny

playbook inventory file: serverslist

cat serverslist
[DEV]
10.10.10.10
10.10.10.11

Users Access list file: accesslist

cat accesslist
GRANTEDSSHUSERS:
  user1: { name: 'user1' }
  user2: { name: 'user2' }

DENIEDSSHUSERS:
  user3: { name: 'user3' }

