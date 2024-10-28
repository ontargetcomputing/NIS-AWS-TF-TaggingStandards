provider "aws" {
  region = var.AWS_REGION

  default_tags {
    tags = {
      #"DHCS:SourceControl" = "${var.GIT_REPO_URL}:${var.GIT_COMMIT_HASH}"
      "DHCS:Environment" = var.env
    }
  }
}