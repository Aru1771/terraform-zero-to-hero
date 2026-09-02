* if we are using local varibles then we no need to mention variable block for the resource value in the variable.tf file
* but when we are using common_tags + resource-specific tag's we have to use merge() block to combine both of them.

* for loacal varibles tags we can directly add those varible blocks in variables.tf and values in .tfvars file
   
