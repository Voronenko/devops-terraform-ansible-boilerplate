# Static parameters
WORKSPACE=$(
  cd $(dirname "$0")
  pwd
)

BOX_PLAYBOOK=$WORKSPACE/playbook.yml
BOX_NAME=bootstrapped_box
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
