# gcp_shell_account

Configures gcloud and gsutils shell with the role credentials. Otherwise it does nothing.

## Configuration

Please read [Common Configuration](../../README.md#common-configuration) as well.

## Example

```YAML
---
- name: Example playbook
  hosts: local
  roles:
    - role: lazyninjas.gcp.gcp_shell_account
```
