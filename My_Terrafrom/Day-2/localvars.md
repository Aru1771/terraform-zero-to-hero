* if we are using local varibles then we no need to mention variable block for the resource value in the variable.tf file
* but when we are using common_tags + resource-specific tag's we have to use merge() block to combine both of them.

* for loacal varibles tags we can directly add those varible blocks in variables.tf and values in .tfvars file
   
Eg:

| Value           | Type           | `variables.tf`? |
| --------------- | -------------- | --------------- |
| `project_name`  | Input variable | ✅ Yes           |
| `environment`   | Input variable | ✅ Yes           |
| `ami_id`        | Input variable | ✅ Yes           |
| `instance_type` | Input variable | ✅ Yes           |
| `name_prefix`   | Local variable | ❌ No            |
| `common_tags`   | Local variable | ❌ No            |
