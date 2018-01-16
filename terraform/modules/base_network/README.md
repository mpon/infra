# base_network

## usage

```hcl
module "base_network" {
  source = "../modules/base_network"

  name = "my-vpc"
  cidr_block {
    vpc = "10.5.28.0/22"
    public_a = "${cidrssubnet("10.5.28.0/22", 2, 0)}"
    public_a = "${cidrssubnet("10.5.28.0/22", 2, 1)}"
    private_a = "${cidrssubnet("10.5.28.0/22", 2, 2)}"
    private_a = "${cidrssubnet("10.5.28.0/22", 2, 3)}"
  }
}
```
