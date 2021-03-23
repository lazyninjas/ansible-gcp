#!/usr/bin/env bash

# This script helps to run ansible on bitbucket pipelines by doing the tiny
# simple things you'd have to write repeatedly
# https://github.com/lazyninjas/ansible-gcp

repo_root=$(git rev-parse --show-toplevel 2> /dev/null)

if [[ "${repo_root}" == "" ]]; then
  repo_root="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
fi



# Humanize input arguments
playbook_path=$(echo $1)
project_environment=$(echo $2)

# Install dependencies
if [[ $(which ansible) == "" ]]; then
  cmd=pip
  if [[ $(which pip3) != "" ]]; then
    cmd=pip3
  fi
  $cmd install ansible
fi

if [[ $(ansible-galaxy collection list | grep lazyninjas.gcp) == "" ]]; then
  ansible-galaxy collection install lazyninjas.gcp
fi

dir_roles_regular="${repo_root}/__ansible__"
dir_roles_lerna="${repo_root}/packages/__ansible__"

# We expect local roles under __ansible__ dir
if [ -d $dir_roles_regular ]; then
  ansible_dir=$(realpath $dir_roles_regular)
fi

# Lazy if for lerna users
if [ -d $dir_roles_lerna ]; then
  ansible_dir=$(realpath $dir_roles_lerna)
fi

if [[ "$project_environment" == "" ]]; then
  project_environment="production"
fi

# Configure ansible env vars
export ANSIBLE_DIR="${ansible_dir}"
export ANSIBLE_ROLES_PATH="${ANSIBLE_DIR}/roles"
export GCP_SERVICE_ACCOUNT_FILE="$(realpath ./.credentials.json)"
export GCP_PROJECT_ENVIRONMENT="$project_environment"

# Consume environment specific variables
# This part de-prefixes variables prefixed with environment name
# For example: STATGING_DEPLOY_CREDENTIALS -> DEPLOY_CREDENTIALS
env_prefix=${GCP_PROJECT_ENVIRONMENT^^}
env_specific=$(printenv | grep "^${env_prefix}" | cut -d '=' -f1)
for var_name in $env_specific; do
  # Strip environment name
  env_name=$(echo $var_name | cut -d _ -f2-)
  # Export as a global variable
  export $env_name="${!var_name}"
done

# Configure gcloud credentials
echo ${DEPLOY_CREDENTIALS} > $GCP_SERVICE_ACCOUNT_FILE

# Configure ansible work path
if [ -d "$playbook_path" ]; then
  cd $playbook_path
  playbook=deploy.yaml
else
  cd $(dirname $playbook_path)
  playbook=$(basename $playbook_path)
fi

inventory_path="$(dirname $playbook)/inventory"

# Create inventory if it does not exist
if [ ! -f $inventory_path ]; then
  interpreter=$(which python3)
  if [[ "$interpreter" == "" ]]; then
    interpreter=$(which python)
  fi
  echo -e "[local]\n127.0.0.1\n\n[local:vars]\nansible_python_interpreter=${interpreter}\nansible_connection=local" > $inventory_path
fi

# Run ansible
ansible-playbook "${playbook}" -i "${inventory_path}"
