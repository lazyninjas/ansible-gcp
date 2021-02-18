# gcp_function

Deploys GCP/Google Cloud Platform **Cloud Functions**.

## Configuration

| Name      | Default | Required | Description                               |
|-----------|---------|----------|-------------------------------------------|
| functions |         | ✓        | Array of function configurations (object) |

### Function configuration

| Name          | Default        | Required | Description                                          |
|---------------|----------------|----------|------------------------------------------------------|
| name          |                | ✓        | Cloud Function name, should be kebab-case            |
| artifact_path |                | ✓        | Path to ZIP file with your function code             |
| source_path   |                | ✓        | Path to function sources, used to autodetect version |
| entry_point   |                | ✓        | Entry function name                                  |
| env_vars      |                | ⨉        | Dictionary of environmental variables for the func   |
| event_trigger |                | *        | Event trigger configuration (object)                 |
| region        | {{gcp_region}} | ✓        | Region where the function should be placed           |
| runtime       | nodejs14       | ✓        | [Runtime ID](https://cloud.google.com/functions/docs/concepts/exec) |
| trigger_http  | false          | *        | Should this function be triggered via HTTP           |
| version       | *detected*     | ✓        | Function version, semver                             |

<small>`*` either `event_trigger` or `trigger_http` must be provided</small>

### Event trigger configuration

For detailed explanation, please see [EventTrigger](https://cloud.google.com/functions/docs/reference/rest/v1/projects.locations.functions#EventTrigger) at Google API docs.

| Name          | Required | Description                                     |
|---------------|----------|-------------------------------------------------|
| event_type    | ✓        | Event type name *                               |
| resource      | ✓        | GCP Resource URI, usually required              | 
| service       | ~        | Hostname of the service that should be observed |
| failurePolicy | ⨉        | [Specifies policy for failed executions](https://cloud.google.com/functions/docs/reference/rest/v1/projects.locations.functions#FailurePolicy) |

`*` To see list of available event types, run `gcloud functions event-types list`

Please read [common configuration](../../README.md#Common+Configuration) as well.

### List of typical event types

* google.pubsub.topic.publish
* google.storage.object.archive
* google.storage.object.delete
* google.storage.object.finalize
* google.storage.object.metadataUpdate
* providers/cloud.firestore/eventTypes/document.create
* providers/cloud.firestore/eventTypes/document.delete
* providers/cloud.firestore/eventTypes/document.update
* providers/cloud.firestore/eventTypes/document.write
* providers/cloud.pubsub/eventTypes/topic.publish
* providers/cloud.storage/eventTypes/object.change
* providers/google.firebase.analytics/eventTypes/event.log
* providers/google.firebase.database/eventTypes/ref.create
* providers/google.firebase.database/eventTypes/ref.delete
* providers/google.firebase.database/eventTypes/ref.update
* providers/google.firebase.database/eventTypes/ref.write

## Example

```YAML
---
- name: Example playbook
  hosts: local
  roles:
    - role: lazyninjas.gcp.gcp_function
      functions:
        - name: example-function
          artifact_path: ../../dist/my-function.zip
          source_path: ../my-function
          entry_point: runThisAwesomeFunction
          runtime: nodejs12
          trigger_http: true
        - name: example-function-2
          artifact_path: ../../dist/my-function.zip
          source_path: ../my-function
          entry_point: runOtherAwesomeFunction
          runtime: nodejs12
          event_trigger:
            event_type: google.storage.object.finalize
            resource: projects/_/buckets/regular-bucket-name  
```

## Roadmap

* Use async tasks to deploy functions
