datacenter = "test"

data_dir = "/tmp/nomad"

bind_addr = "0.0.0.0"

advertise {
  http = "{{ GetPrivateIP }}:4646"
  rpc  = "{{ GetPrivateIP }}:4647"
  serf = "{{ GetPrivateIP }}:4648"
}
