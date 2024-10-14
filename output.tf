output "repository_urls" {
  description = "URLs of the created Bitbucket repositories"
  value = {
    for repo_key, repo in bitbucket_repository.repositories : 
    repo_key => "https://bitbucket.org/${var.workspace_name}/${repo.slug}"
  }
}

output "repository_details" {
  description = "Detailed information about the created Bitbucket repositories"
  value = {
    for repo_key, repo in bitbucket_repository.repositories : 
    repo_key => {
      name = repo.name
      slug = repo.slug
      url  = "https://bitbucket.org/${var.workspace_name}/${repo.slug}"
      language = repo.language
      description = repo.description
    }
  }
}

output "project_key" {
  description = "The key of the created Bitbucket project"
  value = bitbucket_project.project.key
}

output "workspace_name" {
  description = "The name of the Bitbucket workspace"
  value = var.workspace_name
}