# gcp_scheduler

Enables Cloud Scheduler API and creates/destroys Cloud Schedulers in GCP/Google Cloud Platform.

## Configuration

| Name       | Default | Required | Description                   |
|------------|---------|----------|-------------------------------|
| schedulers |         | ✓        | Array of schedulers (string)  |


Please read [Common Configuration](../../README.md#common-configuration) as well.

## Example

```YAML
---
- name: Example playbook
  hosts: local
  roles:
    - role: lazyninjas.gcp.gcp_scheduler
      gcp_region: europe-west3
      schedulers:
        - name: publish-message
          description: Example pubsub message publish
          schedule: '0 */12 * * *'
          pubsub_target:
            data: '{"message": "Please download all surveys"}'
            topic_name: 'projects/{{ gcp_project_id }}/topics/{{ topics.surveys }}'
```

## Roadmap

* Improve documentation
* Use async tasks to deploy schedulers
