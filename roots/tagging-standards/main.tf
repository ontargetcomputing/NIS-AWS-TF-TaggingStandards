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
    "DHCS:ProgamContact": {
      "tag_key": {
        "@@assign": "DHCS:ProgamContact"
      }
    },
    "DHCS:InfrastructureContact": {
      "tag_key": {
        "@@assign": "DHCS:InfrastructureContact"
      }
    },  
    "DHCS:ApplicationContact": {
      "tag_key": {
        "@@assign": "DHCS:ApplicationContact"
      }
    },  
    "DHCS:ApprovalReference": {
      "tag_key": {
        "@@assign": "DHCS:ApprovalReference"
      }
    },  
    "DHCS:Description": {
      "tag_key": {
        "@@assign": "DHCS:Description"
      }
    },  
    "DHCS:DataClassification": {
      "tag_key": {
        "@@assign": "DHCS:DataClassification"
      },
      "tag_value": {
        "@@assign": [
          "PI", "PHI", "SSA", "SENSITIVE", "PUBLIC", "HIPAA", "PII", "Confidential"
        ]
      },      
      "enforced_for": {
        "@@assign": [
            "elasticfilesystem:*", "s3:bucket", "ec2:instance", "dynamodb:table"
        ]
      }
    },  
    "DHCS:Fips199Categorization": {
      "tag_key": {
        "@@assign": "DHCS:Fips199Categorization"
      },
      "tag_value": {
        "@@assign": [
          "Low", "Moderate", "High"
        ]
      },      
      "enforced_for": {
        "@@assign": [
            "elasticfilesystem:*", "s3:bucket", "ec2:instance", "dynamodb:table"
        ]
      }
    },
    "DHCS:Encryption": {
      "tag_key": {
        "@@assign": "DHCS:Encryption"
      },
      "tag_value": {
        "@@assign": [
          "Low", "Moderate", "High"
        ]
      },      
      "enforced_for": {
        "@@assign": [
            "elasticfilesystem:*", "s3:bucket", "ec2:instance", "dynamodb:table"
        ]
      }
    },  
    "Name": {
      "tag_key": {
        "@@assign": "Name"
      }
    },
    "DHCS:Environment": {
      "tag_key": {
        "@@assign": "DHCS:Environment"
      }
    },
    "DHCS:Application": {
      "tag_key": {
        "@@assign": "DHCS:Application"
      }
    },
    "DHCS:SourceControl": {
      "tag_key": {
        "@@assign": "DHCS:SourceControl"
      }
    },
    "DHCS:IacContext": {
      "tag_key": {
        "@@assign": "DHCS:IacContext"
      }
    },
    "DHCS:BackupPolicy": {
      "tag_key": {
        "@@assign": "DHCS:BackupPolicy"
      }
    },
    "DHCS:PatchGroup": {
      "tag_key": {
        "@@assign": "DHCS:PatchGroup"
      }
    },
    "DHCS:MaintenanceWindow": {
      "tag_key": {
        "@@assign": "DHCS:MaintenanceWindow"
      }
    },
    "CostCenter": {
      "tag_key": {
        "@@assign": "CostCenter"
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
