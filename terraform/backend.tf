terraform {
  backend "gcs" {
    bucket = "webservice-terraform-state-bucket"
    prefix = "terraform/state"
  }
}
