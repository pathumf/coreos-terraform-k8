# coreos-terraform-k8

##Prerequisits
Terraform 
GNU Make

#Export aws keys
export AWS_ACCESS_KEY_ID='*yourkey*'
export AWS_SECRET_ACCESS_KEY='*yoursecretaccesskey*'

#How to create Kubernetes cluster
execute : make apply

**If you are planning to use this in production regenerate CA and related keys**
