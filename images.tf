data "docker_registry_image" "wiki_js" {
  name = var.wiki_js_image_name
}

data "docker_registry_image" "postgres" {
  name = var.postgres_image_name
}

resource "docker_image" "wiki_js_image" {
  name          = data.docker_registry_image.wiki_js.name
  pull_triggers = [data.docker_registry_image.wiki_js.sha256_digest]
  keep_locally  = true
}

resource "docker_image" "postgres_image" {
  name = data.docker_registry_image.postgres.name
  pull_triggers = [data.docker_registry_image.postgres.sha256_digest]
  keep_locally = true
}
