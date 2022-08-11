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
    preemptible = false
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

resource "yandex_kubernetes_cluster" "kubernetes" {
 network_id = var.network_id
 master {
   zonal {
     zone      = var.zone
     subnet_id = var.subnet_id
   }
   public_ip = true
 }
 service_account_id      = var.sa_id
 node_service_account_id = var.sa_id
#    depends_on = [
#      yandex_resourcemanager_folder_iam_binding.editor,
#      yandex_resourcemanager_folder_iam_binding.images-puller
#    ]
}

# resource "yandex_vpc_network" "<имя сети>" { name = "<имя сети>" }

# resource "yandex_vpc_subnet" "<имя подсети>" {
#  v4_cidr_blocks = ["<диапазон адресов подсети>"]
#  zone           = "<зона доступности>"
#  network_id     = yandex_vpc_network.<имя сети>.id
# }

# resource "yandex_iam_service_account" "<имя сервисного аккаунта>" {
#  name        = "<имя сервисного аккаунта>"
#  description = "<описание сервисного аккаунта>"
# }

# resource "yandex_resourcemanager_folder_iam_binding" "editor" {
#  # Сервисному аккаунту назначается роль "editor".
#  folder_id = "<идентификатор каталога>"
#  role      = "editor"
#  members   = [
#    "serviceAccount:${yandex_iam_service_account.<имя сервисного аккаунта>.id}"
#  ]
# }

# resource "yandex_resourcemanager_folder_iam_binding" "images-puller" {
#  # Сервисному аккаунту назначается роль "container-registry.images.puller".
#  folder_id = "<идентификатор каталога>"
#  role      = "container-registry.images.puller"
#  members   = [
#    "serviceAccount:${yandex_iam_service_account.<имя сервисного аккаунта>.id}"
#  ]
# }

resource "yandex_kubernetes_node_group" "nodes" {
  cluster_id = yandex_kubernetes_cluster.kubernetes.id

  instance_template {
    platform_id = "standard-v1"

    resources {
      cores  = 2
      memory = 4
    }

    boot_disk {
      size = 30
      type = "network-ssd"
    }

    scheduling_policy {
      preemptible = false
    }

    network_interface {
      # Указан id подсети default-ru-central1-a
      subnet_ids = ["${var.subnet_id}"]
      nat        = true
    #   security_group_ids = [
    #     yandex_vpc_security_group.k8s-main-sg.id,
    #     yandex_vpc_security_group.k8s-nodes-ssh-access.id,
    #     yandex_vpc_security_group.k8s-public-services.id
    #   ]
    }

    # metadata = {
    #   user-data = "${file("./metadata")}"
    # }
  }

  scale_policy {
    fixed_scale {
      size = 2
    }
  }
}
