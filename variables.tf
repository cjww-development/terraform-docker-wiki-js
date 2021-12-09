variable "docker_host" {
  type        = string
  description = "The host where docker resides"
}

variable "wiki_js_image_name" {
  type        = string
  description = "The name of the Wiki Js docker image that should be pulled"
}

variable "postgres_image_name" {
  type        = string
  description = "The name of the postgres docker image that should be pulled"
}

variable "wiki_js_volume_name" {
  type        = string
  description = "The name of the docker volume to be used by the Wiki Js container"
}

variable "wiki_js_network_name" {
  type        = string
  description = "The name of the docker network that the Wiki Js container will be connected to"
}

variable "wiki_js_container_name" {
  type        = string
  description = "The name of the Wiki Js container to be created"
}

variable "postgres_container_name" {
  type        = string
  description = "The name of the Postgres container to be created"
}

variable "restart_policy" {
  type        = string
  description = "The restart policy for the container. Must be one of 'no', 'on-failure', 'always', 'unless-stopped'. Defaults to no."
  validation {
    condition = contains(
    [
      "no",
      "on-failure",
      "always",
      "unless-stopped"
    ],
    var.restart_policy
    )
    error_message = "The provided value did not match a valid value."
  }
}

variable "access_port" {
  type        = number
  description = "The host port number the internal port 3001 will map to"
  default     = 3001
}

variable "access_interface_bind" {
  type        = string
  description = "The network interface that the 3001 port will bind to"
  default     = "0.0.0.0"
}

variable "postgres_db_name" {
  type = string
  description = "The name of the database that the wiki js data should be stored in"
}

variable "postgres_db_username" {
  type = string
  description = "The username that Wiki Js should use to connect the database"
}

variable "postgres_db_password" {
  type = string
  description = "The password that Wiki Js should use to connect the database"
}
