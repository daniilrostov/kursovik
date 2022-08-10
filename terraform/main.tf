terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
  service_account_key_file = var.service_account_key_file
}

resource "yandex_compute_instance" "gitlab" {
  name = "gitlab"

  labels = {
    tags = "gitlab"
  }
  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = var.gitlab_disk_image
      size = 50
    }
  }

  scheduling_policy {
    preemptible = true
  }

  network_interface {
    subnet_id = var.subnet_id
    nat = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }

  connection {
    type  = "ssh"
    host  = yandex_compute_instance.gitlab.network_interface.0.nat_ip_address
    user  = "ubuntu"
    agent = false

    # путь до приватного ключа
    private_key = file(var.private_key_path)
  }

  provisioner "file" {
    source      = "./files/docker-compose.yml"
    destination = "/tmp/docker-compose.yml"
  }
  provisioner "remote-exec" {
    inline = [ "sed -i 's/external_ip/${yandex_compute_instance.gitlab.network_interface.0.nat_ip_address}/' /tmp/docker-compose.yml" ]
  }
  provisioner "remote-exec" {
    script = "./files/deploy_gitlab.sh"
  }
}

# resource "yandex_vpc_network" "gitlab-network" {
#   name = "gitlab-network"
# }

# resource "yandex_vpc_subnet" "gitlab-subnet" {
#   name           = "gitlab-subnet"
#   zone           = var.net_zone
#   network_id     = yandex_vpc_network.gitlab-network.id
#   v4_cidr_blocks = ["192.168.10.0/24"]
# }
