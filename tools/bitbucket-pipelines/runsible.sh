#!/usr/bin/env bash

repo_root="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

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

# We expect local roles under __ansible__ dir
ansible_dir=$(realpath "${repo_root}/__ansible__")

# Lazy if for lerna users
if [ -d packages/__ansible__ ]; then
  ansible_dir=$(realpath "${repo_root}/packages/__ansible__")
fi

# Configure ansible env vars
export ANSIBLE_DIR="${ansible_dir}"
export ANSIBLE_ROLES_PATH="${ANSIBLE_DIR}/roles"
export GCP_CREDENTIALS_PATH="$(realpath ./.credentials.json)"
export GCP_PROJECT_ENVIRONMENT="$project_environment"

# Configure gcloud credentials
echo ${DEPLOY_CREDENTIALS} > $GCP_CREDENTIALS_PATH

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
