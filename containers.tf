resource "docker_container" "postgres" {
  name  = var.postgres_image_name
  hostname = var.postgres_image_name
  image = docker_image.postgres_image.latest

  restart = var.restart_policy

  volumes {
    container_path = "/var/lib/postgresql/data"
    host_path      = docker_volume.wiki_js_volume.mountpoint
    read_only      = false
  }

  networks_advanced {
    name = docker_network.wiki_js_network.name
  }

  env = [
    "POSTGRES_DB=${var.postgres_db_name}",
    "POSTGRES_USER=${var.postgres_db_username}",
    "POSTGRES_PASSWORD=${var.postgres_db_password}"
  ]
}

resource "docker_container" "wiki_js" {
  name  = var.wiki_js_container_name
  image = docker_image.wiki_js_image.latest

  restart = var.restart_policy

  ports {
    internal = 3000
    external = var.access_port
    ip       = var.access_interface_bind
    protocol = "tcp"
  }

  networks_advanced {
    name = docker_network.wiki_js_network.name
  }

  env = [
    "DB_TYPE=postgres",
    "DB_HOST=${docker_container.postgres.hostname}",
    "DB_PORT=5432",
    "DB_USER=${var.postgres_db_username}",
    "DB_PASS=${var.postgres_db_password}",
    "DB_NAME=${var.postgres_db_name}"
  ]
}
