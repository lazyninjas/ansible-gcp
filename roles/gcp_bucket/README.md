# gcp_bucket

Creates and destroys Storage Buckets in GCP/Google Cloud Platform.

## Configuration

| Name    | Default | Required | Description                             |
|---------|---------|----------|-----------------------------------------|
| buckets |         | ✓        | Array of bucket configurations (object) |

### Bucket configuration

| Name    | Default        | Required | Description                               |
|---------|----------------|----------|-------------------------------------------|
| name    |                | ✓        | Bucket name, should be kebab-case         |
| region  | {{gcp_region}} | ✓        | Region where the bucket should be placed  |
| public  | false          | ✓        | Should contents of this bucket be public? |

Please read [Common Configuration](../../README.md#common-configuration) as well.

## Example

```YAML
---
- name: Example playbook
  hosts: local
  roles:
    - role: lazyninjas.gcp.gcp_bucket
      gcp_region: europe-west3
      buckets:
        - name: example-bucket
        - name: example-bucket-across-ocean
          region: us-west1
          public: true
```

## Roadmap

* Use async tasks to deploy buckets
