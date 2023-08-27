vm_name = ["k8s-master2", "k8s-worker2", "k8s-infra2"]
pool_name = "images"
source_url = "http://server0.homelabs.org/custom-ubuntu-22-server.qcow2"

memory = ["4096", "4096", "4096"]
cpu = ["2", "2", "2"]
bridge_name = "external-br"

ipaddress = ["192.168.2.111", "192.168.2.114", "192.168.2.117"]
dns = "192.168.2.1"
dns_search = "homelabs.org"
domain = "homelabs.org"
gateway = "192.168.2.1"