# Demo:  using ansible and terraform to deploy wordpress application

In this demo from oops-to-devops services  https://github.com/topics/oops-to-devops we provide
example, how ansible and terraform flows might be splitted between infrastructure deployment 
and business logic deployment.


Folders structure:

## providers/<provider-name>/

Under providers we put terraform logic, that will create necessary infrastructure for us.
As your project might be deployed to multiple clouds, you can end with separate terraform scenarios 
for those activities, thus it can be reasonable, to put project under folder, named by cloud provider,
like `providers/digitalocean/...` 


## provisioners/shared/

Here we collect knowledge needed to deploy your project. In particular,

### provisioners/env/

This is shared folder for environment overrides, i.e. specific parameters, that differ across
deployments - like fqdn, passwords, options etc.

Here and below ENV stands for environment name, like prod, staging, dev and so on.

Note that this is the place, where you can inject encrypted secrets, for example using ansible vault.
Order of proving overrides is following:

- env-ENV-vars.yml
- env-default-vars.yml

### provisioners/providers/

Idea close to what we have with environments, but here you can put specific 
to cloud provider used. Note, that you also can encrypt sensitive data here with ansible vault. 

overrides will be searched in the following order (first found will be picked up):

```
- PROVIDER-ENV-vars.yml
- PROVIDER-vars.yml
``` 

### provisioners/files/

Any fixed file artifacts you might have - team ssh keys, etc

### provisioners/inventory/

Under this directory, terraform script will generate inventory files for ansible, basing 
on information about resources created.

Typical structure you will see here 

```
inventory/prod/...
inventory/staging/...

...

inventory/default/...
```

You can explore inventory with `ansible-inventory`

```
 ansible-inventory -i default/ --graph
@all:
  |--@aws_ec2:
  |--@ungrouped:
```

### Deployment environment

also it is assumed, that following environment variables are set:

INFRASTRUCTURE_ROOT_DIR, which defaults to root project of the solution,
ANSIBLE_VAULT_IDENTITY_LIST, which hels ansible to decrypt encrypted values

```
export INFRASTRUCTURE_ROOT_DIR=$PWD
export ANSIBLE_VAULT_IDENTITY_LIST="@$HOME/path/to/vault"
```

also you should provide any other environment variables needed for provisioning.
For example, for this demo we will be using digitalocean token to create resources,
and godaddy key pair to create DNS entry.

```
export DIGITALOCEAN_TOKEN=hihi
export GD_KEY=haha
export GD_SECRET=hehe
```

## Provisioning considerations

Server roles used are proposed to be stored under `provisioners/<server-role>-box` with a
specific structure for environment variables:

```
BOX_ADDRESS - address of the box, or path to inventory
BOX_PROVIDER - provider used (digitalocean, aws, etc)
BOX_DEPLOY_USER - user used to connect to server for provisioning
BOX_DEPLOY_PASS - provisioning user password, if any
ENVIRONMENT - current environment, like prod, staging, dev


REMOTE_USER_INITIAL - only for fresh instance, not prepared for deployment yet
REMOTE_PASSWORD_INITIAL - only for fresh instance, not prepared for deployment yet
```

Typical provisioning script would be

```bash

# Static parameters
WORKSPACE=$(
  cd $(dirname "$0")
  pwd
)

BOX_PLAYBOOK=$WORKSPACE/<SERVER-ROLE-PLAYBOOK>.yml
BOX_NAME=<SERVER-ROLE>
BOX_ADDRESS=$REMOTE_HOST
BOX_USER=$REMOTE_USER_INITIAL
BOX_PWD=$REMOTE_PASSWORD_INITIAL
BOX_PROVIDER=${BOX_PROVIDER:-}
ENVIRONMENT=${ENVIRONMENT:-default}

prudentia ssh <<EOF
unregister $BOX_NAME

register
$BOX_PLAYBOOK
$BOX_NAME
$BOX_ADDRESS
$BOX_USER
$BOX_PWD

verbose 1
set box_address $BOX_ADDRESS
set box_deploy_pass $BOX_DEPLOY_PASS
set ansible_become_password $BOX_PWD
set box_provider $BOX_PROVIDER
set env $ENVIRONMENT

provision $BOX_NAME
EOF

```

And bridge between terraform and ansible might look as:

```hcl
resource "null_resource" "letsencrypted_servers" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers {
    cluster_instance_ids = "${join(",", digitalocean_droplet.web.*.id)}"
  }


  provisioner "local-exec" {

    command = "$INFRASTRUCTURE_ROOT_DIR/provisioners/letsencrypted-box/provision_box.sh"

    environment {
      REMOTE_HOST = "${digitalocean_droplet.web.ipv4_address}"
      BOX_DEPLOY_USER = "ubuntu"
      BOX_DEPLOY_PASS = ""
      BOX_PROVIDER = "digitalocean"
    }

  }

  depends_on = ["null_resource.baseboxed_servers"]
}
```

Now lets proceed in a interactive session in details


## Support for shared parts

Typical common "loader" for plays to get overrides from environment and provider level

```yml

- hosts: currenthost
  gather_facts: False

  vars:
    - root_dir: "{{ playbook_dir }}"
    - shared_dir: "{{ playbook_dir }}/../shared"

  pre_tasks:
    - debug: msg="Pre tasks section for {{ansible_host}}"

    - name: gather facts
      setup:

    - name: Check for common pretasks
      local_action: stat path="{{shared_dir}}/common_pretasks.yml"
      register: common_pretasks_exists
      tags: always

    - name: Include common pretasks
      include_tasks: "{{shared_dir}}/common_pretasks.yml"
      when: common_pretasks_exists.stat.exists == true
      tags: always

```
