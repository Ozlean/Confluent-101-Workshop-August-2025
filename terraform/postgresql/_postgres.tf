terraform {
  required_providers {
    postgresql = {
      source = "cyrilgdn/postgresql"
      version = "1.25.0"
    }
  }
}

provider "postgresql" {
  alias = "RDS1-src"
  host = data.terraform_remote_state.aws.outputs.RDS1_VARS["RDS1_HOST"]
  port = data.terraform_remote_state.aws.outputs.RDS1_VARS["RDS1_PORT"]
  database = data.terraform_remote_state.outputs.aws.RDS1_VARS["RDS1_DATABASE"]
  username = data.terraform_remote_state.outputs.aws.RDS1_VARS["RDS1_USER"]
  password = data.terraform_remote_state.outputs.aws.RDS1_VARS["RDS1_PASSWORD"]
  superuser = false

}

provider "postgresql" {
  alias = "RDS2-dst"
  port = data.terraform_remote_state.aws.outputs.RDS2_VARS["RDS2_PORT"]
  host = data.terraform_remote_state.aws.outputs.RDS2_VARS["RDS2_HOST"]
  database = data.terraform_remote_state.aws.outputs.RDS2_VARS["RDS2_DATABASE"]
  username = data.terraform_remote_state.aws.outputs.RDS2_VARS["RDS2_USER"]
  password = data.terraform_remote_state.aws.outputs.RDS2_VARS["RDS2_PASSWORD"]
  superuser = false

}

resource "postgresql_role" "RDS2-dst-workshopq1" {
    provider = postgresql.RDS2-dst

    name = "workshopq1"
    login = true
    password = data.terraform_remote_state.aws.outputs.RDS2_VARS["RDS2_PASSWORD"]
}

resource "postgresql_grant_role" "grant_rds_superuser" {
  provider    = postgresql.RDS2-dst

  role       = postgresql_role.RDS2-dst-workshopq1.name  
  grant_role = "rds_superuser" 
}

