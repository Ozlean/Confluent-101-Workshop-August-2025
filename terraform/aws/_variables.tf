terraform {
    backend "local" {
        path = "../aws/aws.tfstate"
    }
}

variable "AWS_workshop_terraform_user_key" {
    description = "The access key for the AWS workshop_terraform_user user"
    type = string
}

variable "AWS_workshop_terraform_user_secret" {
    description = "The access secret for the AWS workshop_terraform_user user"
    type = string
}

variable "WEBAPP_AMI" {
    description = "AMI for the webapp"
    type = string
    default = "ami-071299e36e4bb550c"
}

locals  {

    DB_USER = "postgres"
    DB_PASSWORD = "password"
    DB_DEFAULT_NAME = "postgres"

    RDS1_VARS = {
        RDS1_HOST = aws_db_instance.RDS1-src.address
        RDS1_PORT = aws_db_instance.RDS1-src.port
        RDS1_USER = local.DB_USER
        RDS1_PASSWORD = local.DB_PASSWORD
        RDS1_DATABASE = local.DB_DEFAULT_NAME
    }

    RDS2_VARS = {
        RDS2_HOST = aws_db_instance.RDS2-dst.address
        RDS2_PORT = aws_db_instance.RDS2-dst.port
        RDS2_USER = local.DB_USER
        RDS2_PASSWORD = local.DB_PASSWORD
        RDS2_DATABASE = local.DB_DEFAULT_NAME
    }

    WEBAPP_VARS = {
        WEBAPP_HOST = aws_instance.webapp-instance.public_ip
        WEBAPP_PORT = 3000
    }


}

output "RDS1_VARS" {
    value = {
        RDS1_HOST = local.RDS1_VARS.RDS1_HOST
        RDS1_PORT = local.RDS1_VARS.RDS1_PORT
        RDS1_USER = local.RDS1_VARS.RDS1_USER
        RDS1_PASSWORD = local.RDS1_VARS.RDS1_PASSWORD
        RDS1_DATABASE = local.RDS1_VARS.RDS1_DATABASE
    }
}

output "RDS2_VARS" {
    value = {
        RDS2_HOST = local.RDS2_VARS.RDS2_HOST
        RDS2_PORT = local.RDS2_VARS.RDS2_PORT
        RDS2_USER = local.RDS2_VARS.RDS2_USER
        RDS2_PASSWORD = local.RDS2_VARS.RDS2_PASSWORD
        RDS2_DATABASE = local.RDS2_VARS.RDS2_DATABASE
    }
}

output "WEBAPP_VARS" {
    value = {
        WEBAPP_HOST = local.WEBAPP_VARS.WEBAPP_HOST
        WEBAPP_PORT = local.WEBAPP_VARS.WEBAPP_HOST
        WEBAPP_URL = "${local.WEBAPP_VARS.WEBAPP_HOST}:${local.WEBAPP_VARS.WEBAPP_PORT}"
    }

}

resource "local_file" "workshop_instruction_file" {
    filename = "${path.module}/../workshop_instruction_file.md"

    content = templatefile("${path.module}/templates/workshop_instruction_file.tpl", {
        WEBAPP_URL = "${local.WEBAPP_VARS.WEBAPP_HOST}:${local.WEBAPP_VARS.WEBAPP_PORT}"
        RDS1_HOST = local.RDS1_VARS.RDS1_HOST
        RDS1_PORT = local.RDS1_VARS.RDS1_PORT
        RDS1_USER = local.RDS1_VARS.RDS1_USER
        RDS1_PASSWORD = local.RDS1_VARS.RDS1_PASSWORD
        RDS1_DATABASE = local.RDS1_VARS.RDS1_DATABASE
        RDS2_HOST = local.RDS2_VARS.RDS2_HOST
        RDS2_PORT = local.RDS2_VARS.RDS2_PORT
        RDS2_USER = local.RDS2_VARS.RDS2_USER
        RDS2_PASSWORD = local.RDS2_VARS.RDS2_PASSWORD
        RDS2_DATABASE = local.RDS2_VARS.RDS2_DATABASE
    }) 
}