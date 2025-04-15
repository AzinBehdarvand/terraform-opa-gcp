package validate.gcp.storage

deny := [msg |
  some i
  input.resource_changes[i].type == "google_storage_bucket"
  env := input.resource_changes[i].change.after.labels.env
  input.resource_changes[i].change.after.labels.env != "dev"
  msg := sprintf("Invalid env label on bucket %s: %v (only 'dev' allowed)", [input.resource_changes[i].address, env])
]