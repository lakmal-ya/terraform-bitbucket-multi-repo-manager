variable "provider_username" {
  description = "Bitbucket Username"
  type        = string
}

variable "provider_app_key" {
  description = "Bitbucket App Key"
  type        = string
  sensitive   = true
}

variable "workspace_name" {
  description = "Name of workspace"
  type        = string
}

variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "project_key" {
  description = "Key of the project"
  type        = string
}

variable "repositories" {
  description = "Map of repositories to create"
  type = map(object({
    name        = string
    slug        = string
    language    = string
    description = string
    variables   = map(object({
      key     = string
      value   = string
      secured = bool
    }))
    deployments = map(object({
      name   = string
      stage  = string
      variables = map(object({
        key     = string
        value   = string
        secured = bool
      }))
    }))
  }))
}