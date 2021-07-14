# Docker image to create (Volterra) VM on ESXi using Terraform

This [container](https://hub.docker.com/repository/docker/risyou/ves-esxi-terraform) has pre-build ovftool and terraform which can helps you build VM to ESXi without vCenter.

Most importantly, it contains .tf file to build [Volterra VM](https://www.volterra.io/docs/images/node-vmware-images) and pass necessary parameter.

## 1.0 Prepare

```bash
git clone https://github.com/risyou/ves-esxi-terraform
cd ves-vm-terraform
```

Input parameter to variable.tf, download [Volterra ova image](https://www.volterra.io/docs/images/node-vmware-images) to this path.

## 2.0 Run container

Get ova to your working directory
```bash
#Optional
wget https://downloads.volterra.io/releases/images/2021-07-04/centos-7.2009.10-202107041731.ova
```

```bash
docker run -it -v $(PWD):/tmp/ risyou/ves-esxi-terraform
```
This will run container with /bin/sh, the default variable.tf assumes your ova is mounted to /tmp/

## 3.0 Build VM

```
cd /tmp
terraform init
terraform plan
terraform apply
```
#### Note
- If you wish to build from Dockerfile, you need to get [ovftool](https://www.vmware.com/support/developer/ovf/) from vmware and adjust Dockerfile.
- https://github.com/risyou/ves-esxi-terraform
- https://hub.docker.com/repository/docker/risyou/ves-esxi-terraform
