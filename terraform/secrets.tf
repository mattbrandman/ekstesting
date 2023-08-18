resource "kubernetes_secret" "argocd_gitops" {

  metadata {
    name      = "private-repo-secrets"
    namespace = "argocd"
    labels    = { "argocd.argoproj.io/secret-type" : "repo-creds" }
  }

  data = {
    sshPrivateKey = data.aws_secretsmanager_secret_version.ssh_key_version.secret_string
    type          = "git"
    url           = "git@github.com:mattbrandman/"
  }
}

data "aws_secretsmanager_secret" "ssh_key" {
  name = "argo_ssh_key"
}

data "aws_secretsmanager_secret_version" "ssh_key_version" {
  secret_id = data.aws_secretsmanager_secret.ssh_key.id
}
