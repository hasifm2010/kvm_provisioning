vm_name = ["k8s-master1", "k8s-worker1", "k8s-infra1"]
pool_name = "images"
source_url = "http://server0.homelabs.org/custom-ubuntu-22-server.qcow2"

memory = ["4096", "4096", "4096"]
cpu = ["2", "2", "2"]
bridge_name = "external-br"

ipaddress = ["192.168.2.110", "192.168.2.113", "192.168.2.116"]
dns = "192.168.2.1"
dns_search = "homelabs.org"
domain = "homelabs.org"
gateway = "192.168.2.1"