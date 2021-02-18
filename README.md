# Practical GCP

Collection of ansible roles used to deploy resources to GCP. Used to minify work when deploying your complicated cloud projects. Expected to be run on continous integration tools like Bitbucket Pipelines or Github Actions.

* [gcp_api](./roles/gcp_api) - Enables individual service APIs
* [gcp_function](./roles/gcp_function) - Deploys Cloud Functions
* [gcp_bucket](./roles/gcp_bucket) - Creates Storage Buckets

## Common Configuration

Most of the global variables can be auto configured using environment variables and overriden by passing them to the specific role.

| Name/Environment name                               | Default    | Required | Description           |
|-----------------------------------------------------|------------|----------|-----------------------|
| gcp_project_id / GCP_PROJECT_ID                     | null       | ✓        | Your GCP project ID   |
| gcp_region / GCP_REGION                             | null       | ✓        | Region for this role  |
| gcp_service_account_file / GCP_SERVICE_ACCOUNT_FILE | null       | ✓        | Path to the service account file with credentials |
| state                                               | present    | ✓        | `present` or `absent` |
| gcp_project_environment / GCP_PROJECT_ENVIRONMENT   | production | ⨉        | Lowercase name of your project environment. The role will append datetime to your versions if the name is not production | 
