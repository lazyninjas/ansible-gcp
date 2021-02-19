# gcp_bucket

Creates and destroys Storage Buckets in GCP/Google Cloud Platform.

## Configuration

| Name    | Default | Required | Description                   |
|---------|---------|----------|-------------------------------|
| topics  |         | ✓        | Array of topic names (string) |


Please read [Common Configuration](../../README.md#common-configuration) as well.

## Example

```YAML
---
- name: Example playbook
  hosts: local
  roles:
    - role: lazyninjas.gcp.gcp_topic
      gcp_region: europe-west3
      topics:
        - example-topic
        - example-topic-2
```

## Roadmap

* Use async tasks to deploy topics
