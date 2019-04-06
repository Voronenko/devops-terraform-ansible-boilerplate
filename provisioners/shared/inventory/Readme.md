# Put inventories here

For aws, terraform fact is

`terraform output inventory_ec2` 

suggested structure

inventory/prod/...
inventory/staging/...

...

inventory/default/...


Inventory can be explored with `ansible-inventory`

 ansible-inventory -i default/ --graph
@all:
  |--@aws_ec2:
  |--@ungrouped:
