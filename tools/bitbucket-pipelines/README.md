# Bitbucket Pipelines helpers

This is a tiny collection of Bitbucket Pipelines helpers that will make running ansible easier for you.

## runsible.sh

This script will install ansible and configure some basic stuff and create localhost inventory from Pipeline environment for you.

It expects to be put in the repository root.

```shell
# ./runsible.sh [path_to_playbook] [project_environment]
./runsible.sh production packages/my-func/deploy.yaml
```

### Variable: DEPLOY_CREDENTIALS

This envrionmental variable should contain the whole credentials file for your GCP service account.

### Local roles

This file expects your local roles (if any) to be located either in `__ansible__/roles` directory or in `packages/__ansible__/roles`.

### Usage

1. Create your playbook.

```yaml
---
# packages/__ansible__/buckets.yaml
- name: Example playbook
  hosts: local # Configured in default inventory
  roles:
    - role: lazyninjas.gcp.gcp_bucket
      buckets:
        - name: test-bucket
```

2. Download runsible.sh into your repository root
3. Give it execution rights

```bash
chmod +x runsible.sh
```

4. Configure your pipeline

```yaml
---
image: google/cloud-sdk:latest
pipelines:
  tags:
    'v*':
      - step:
        name: Create bucket
        script:
          - ./runsible.sh __ansible__/buckets.yaml PRODUCTION
```

