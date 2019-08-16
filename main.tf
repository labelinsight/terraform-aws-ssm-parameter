variable "description" {
  description = "The description of the SSM Parameter"
}

variable "value" {
  description = "The value of the SSM Parameter"
}

variable "secure" {
  description = "Set parameter type to SecureString or String. Default is String. We don't use StringList"
  type = bool
  default = false
}

resource "aws_ssm_parameter" "param" {
  type = var.secure ? "SecureString" : "String"
  description = var.description
  name  = "/${basename(path.cwd)}/${terraform.workspace}/${var.value}"
  value = "${var.value}-${terraform.workspace}"
  overwrite = true

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

output "ssm_parameter_name" {
  value = aws_ssm_parameter.param.name
}

output "ssm_parameter_value" {
  value = aws_ssm_parameter.param.value
}