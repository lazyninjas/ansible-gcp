# gcp_bucket

Creates and destroys Storage Buckets in GCP/Google Cloud Platform.

## Configuration

| Name    | Default | Required | Description                             |
|---------|---------|----------|-----------------------------------------|
| buckets |         | ✓        | Array of bucket configurations (object) |

### Bucket configuration

| Name    | Default        | Required | Description                              |
|---------|----------------|----------|------------------------------------------|
| name    |                | ✓        | Bucket name, should be kebab-case        |
| region  | {{gcp_region}} | ✓        | Region where the bucket should be placed |

Please read [common configuration](../../README.md#Common+Configuration) as well.

## Example

```YAML
---
- name: Example playbook
  hosts: local
  roles:
    - role: gcp_bucket
      gcp_region: europe-west3
      buckets:
        - name: example-bucket
        - name: example-bucket-across-ocean
          region: us-west1
```
