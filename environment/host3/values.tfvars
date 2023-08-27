vm_name = ["k8s-master3", "k8s-worker3", "k8s-infra3"]
pool_name = "images"
source_url = "http://server0.homelabs.org/custom-ubuntu-22-server.qcow2"

memory = ["4096", "4096", "4096"]
cpu = ["2", "2", "2"]
bridge_name = "external-br"

ipaddress = ["192.168.2.112", "192.168.2.115", "192.168.2.118"]
dns = "192.168.2.1"
dns_search = "homelabs.org"
domain = "homelabs.org"
gateway = "192.168.2.1"