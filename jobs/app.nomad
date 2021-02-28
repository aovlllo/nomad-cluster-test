locals {
  user = "someuser"
  password = "somepassword1"
}

job "app-nomad" {
  datacenters = ["test"]

  group "app-web" {
    task "app" {
      driver = "docker"
      config {
        image = "ghcr.io/aovlllo/simple-sn:0.9.2"
        dns_search_domains = ["service.consul"]
        dns_servers = ["172.17.0.1", "8.8.8.8"]
      }
      env {
        DB_HOST = "mysql.service.consul"
        DB_USER = "${local.user}"
        DB_PASSWORD = "${local.password}"
      }
    }
    network {
      port "http" {
        static = "8080"
      }
    }
  }
  group "app-test" {
    task "db" {
      driver = "docker"
      config {
        image = "ubuntu"
        dns_search_domains = ["service.consul"]
        dns_servers = ["172.17.0.1", "8.8.8.8"]
        command = "sleep"
        args = ["3600"]
      }
    }
  }
  group "app-db" {
    task "db" {
      driver = "docker"
      config {
        image = "mysql:8.0.23"
        # dns_search_domains = ["service.dc1.consul"]
        # dns_servers = ["172.17.0.1", "8.8.8.8"]
        # ports = ["db"]
      }
      env {
        MYSQL_DATABASE = "example"
        MYSQL_USER = "${local.user}"
        MYSQL_PASSWORD = "${local.password}"
        MYSQL_ROOT_PASSWORD = "somepassword1"
      }
      resources {
        cpu = 300
        memory = 500
      }
      service {
        name = "mysql"
        address_mode = "driver"
        port = 3306
      }
    }
  }
}
