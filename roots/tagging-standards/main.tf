locals {
  context = "taggingstandards"
  name = "${var.env}-taggingstandards"
}
 
 
resource "aws_organizations_policy" "tagpolicy" {
  name        = "${local.name}-tag-policy"
  description = "AWS NIS Tag Policy"
  type        = "TAG_POLICY"
  content = <<CONTENT
{
  "tags": {
    "Environment": {
      "tag_key": {
        "@@assign": "Environment"
      },
      "tag_value": {
        "@@assign": [
          "dev",
          "test",
          "prod"
        ]
      }      
    },
    "name": {
      "tag_key": {
        "@@assign": "name"
      }
    }
  }
}
CONTENT
}

resource "aws_organizations_policy_attachment" "tagpolicattachment" {
  policy_id = aws_organizations_policy.tagpolicy.id
  target_id = "${var.OU}"
}


# resource "aws_organizations_policy" "example_scp" {
#   name        = "EnforceEnvironmentTag"
#   description = "Enforces Environment tag to be either prod or test"
#   content     = <<POLICY
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Deny",
#       "Action": "*",
#       "Resource": "*",
#       "Condition": {
#         "StringNotEquals": {
#           "aws:RequestTag/Environment": [
#             "prod",
#             "test"
#           ]
#         },
#         "Null": {
#           "aws:RequestTag/Environment": "true"
#         }
#       }
#     }
#   ]
# }
# POLICY
#   type = "SERVICE_CONTROL_POLICY"
# }

# # Attach the SCP to an Organizational Unit (OU)
# resource "aws_organizations_policy_attachment" "scp_attachment" {
#   policy_id = aws_organizations_policy.example_scp.id
#   target_id = aws_organizations_organizational_unit.nis_ou.id
# }
