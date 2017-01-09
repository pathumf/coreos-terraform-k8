plan: etcd_discovery
	terraform plan

etcd_discovery:
	curl -s https://discovery.etcd.io/new?size=3 > etcd_discovery_url.txt

destroy:
	terraform destroy
	rm etcd_discovery_url.txt kube_token.txt
	rm -rf tls-assets

apply: etcd_discovery 
	terraform apply
