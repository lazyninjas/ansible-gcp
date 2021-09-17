# gcs_static_website

Configures very basic static website on GCP Cloud Storage bucket.

## Configuration

| Name        | Default | Required | Description              |
|-------------|---------|----------|--------------------------|
| name        |         | ✓        | Name of the project, used for identification. Must by kebab-case |
| dest_bucket |         | ✓        | Destination bucket name  |
| src_dir     |         | ✓        | Path to source directory |
| dns_domain  |         | ✓        | DNS Domain that will be configured to serve the static website |


Please read [Common Configuration](../../README.md#common-configuration) as well.

## Example

```YAML
---
- name: Example playbook
  hosts: local
  roles:
    - role: lazyninjas.gcp.gcs_static_website
      name: 'ui-website'
      dest_bucket: my-bucket-name
      dir: ../dist/docs
      dns_domain: my.domain.cz
      gcp_region: europe-west3
```

## Roadmap

* Enable HTTPS
