# terraform-aws-ssm-parameter
A module to create a consistent namespace for SSM Parameters.

The name and value are generated based on the current working directory, the terraform workspace, and the value. This module is opinionated.


## Module Usage
```
terraform {
  required_version = "> 0.12.6"
}

module "dynamo_db_name" {
  source = "github.com/labelinsight/terraform-aws-ssm-parameter"
  description = "The new Dynamo DB table name for my fancy project"
  value = "fancytable"
}

output "ssm_parameter_name" {
  value = module.dynamo_db_name.ssm_parameter_name
}

output "ssm_parameter_value" {
  value = module.dynamo_db_name.aws_ssm_parameter
}
```

## Argument Reference
The following arguments are supported:

* `description` - The description of the SSM Parameter.

* `value` - The value of the SSM Parameter. 

* `secure` - (Optional) A boolean that sets the parameter type to SecureString or String. We don't use StringList. The default is false (which means String).


## Attributes Reference
In addition to all arguments above, the following attributes are exported:

* `ssm_parameter_name` - The generated name of the SSM parameter. In the case of the above example usage, it would be "/fancyproject/prod/fancytable"

* `ssm_parameter_value` - The final value of the SSM parameter. In the case of the above example usage, it would be "fancytable-prod"


