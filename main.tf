data "bitbucket_workspace" "workspace" {
  workspace = var.workspace_name 
}

resource "bitbucket_project" "project" {
  owner = var.workspace_name
  name  = var.project_name
  key   = var.project_key
}

resource "bitbucket_repository" "repositories" {
  for_each = var.repositories

  owner             = bitbucket_project.project.owner
  project_key       = bitbucket_project.project.key
  name              = each.value.name
  slug              = each.value.slug 
  language          = each.value.language
  description       = each.value.description
  is_private        = true
  pipelines_enabled = true

  depends_on = [bitbucket_project.project]
}

resource "bitbucket_repository_variable" "repo_variables" {
  for_each = {
    for entry in flatten([
      for repo_key, repo in var.repositories : [
        for var_key, var in repo.variables : {
          id       = "${repo_key}.${var_key}"
          repo_key = repo_key
          key      = var.key
          value    = var.value
          secured  = var.secured
        }
      ]
    ]) : entry.id => entry
  }

  key        = each.value.key
  value      = each.value.value
  repository = bitbucket_repository.repositories[each.value.repo_key].id
  secured    = each.value.secured
}

resource "bitbucket_commit_file" "readme_files" {
  for_each = var.repositories

  workspace      = data.bitbucket_workspace.workspace.id
  repo_slug      = bitbucket_repository.repositories[each.key].slug
  filename       = "README.md"
  content        = "# ${each.value.name}\n\n${each.value.description}"
  commit_author  = "Terraform <terraform@example.com>"
  branch         = "main"
  commit_message = "Add README.md"

  depends_on = [bitbucket_repository.repositories]
}

resource "bitbucket_deployment" "deployments" {
  for_each = {
    for entry in flatten([
      for repo_key, repo in var.repositories : [
        for deploy_key, deploy in repo.deployments : {
          id         = "${repo_key}.${deploy_key}"
          repo_key   = repo_key
          deploy_key = deploy_key
          name       = deploy.name
          stage      = deploy.stage
        }
      ]
    ]) : entry.id => entry
  }

  repository = bitbucket_repository.repositories[each.value.repo_key].id
  name       = each.value.name
  stage      = each.value.stage
}

resource "bitbucket_deployment_variable" "deployment_variables" {
  for_each = {
    for entry in flatten([
      for repo_key, repo in var.repositories : [
        for deploy_key, deploy in repo.deployments : [
          for var_key, var in deploy.variables : {
            id         = "${repo_key}.${deploy_key}.${var_key}"
            repo_key   = repo_key
            deploy_key = deploy_key
            key        = var.key
            value      = var.value
            secured    = var.secured
          }
        ]
      ]
    ]) : entry.id => entry
  }

  deployment = bitbucket_deployment.deployments["${each.value.repo_key}.${each.value.deploy_key}"].id
  key        = each.value.key
  value      = each.value.value
  secured    = each.value.secured
}