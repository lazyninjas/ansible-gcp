# Practical GCP

Collection of ansible roles used to deploy resources to GCP. Used to minify work when deploying your complicated cloud projects. Expected to be run on continous integration tools like Bitbucket Pipelines or Github Actions.

* [gcp_api](./roles/gcp_api) - Enables individual service APIs
* [gcp_function](./roles/gcp_function) - Deploys Cloud Functions
* [gcp_bucket](./roles/gcp_bucket) - Creates Storage Buckets

## Common Configuration

Most of the global variables can be auto configured using environment variables and overriden by passing them to the specific role.

| Name                     | Default    | Required | Description           |
|--------------------------|------------|----------|-----------------------|
| state                    | present    | ⨉        | *present* or *absent* |
| gcp_project_id           | null       | ✓        | Your GCP project ID   |
| gcp_region               | null       | ✓        | Region for this role  |
| gcp_service_account_file | null       | ✓        | Path to the service account file with credentials |
| project_environment      | production | ⨉        | Lowercase name of your project environment | 
