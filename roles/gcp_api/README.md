# gcp_api

Ensures specific set of [Services/APIs](https://cloud.google.com/service-usage/docs/list-services) are enabled in GCP/Google Cloud Platform. To get list of GCP services, run 

```shell
gcloud services list
gcloud services list --enabled
```

## Configuration

| Name | Default | Required | Description                       |
|------|---------|----------|-----------------------------------|
| apis |         | ✓        | Array of Google API URLs (string) |

Please read [common configuration](../../README.md#Common+Configuration) as well.

## Example

```YAML
---
- name: Example playbook
  hosts: local
  roles:
    - role: gcp_api
      apis:
        - cloudfunctions.googleapis.com
        - cloudbuild.googleapis.com
```
