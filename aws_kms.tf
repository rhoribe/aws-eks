# Create a KMS key (Customer Managed Key - CMK)
resource "aws_kms_key" "this" {
  description             = "CMK for encryption EKS resources"
  deletion_window_in_days = 30   # Number of days to wait before deleting the key
  enable_key_rotation     = true # Enable automatic key rotation

  # Define the key policy (who can manage and use the key)
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        },
        Action   = "kms:*",
        Resource = "*"
      }
    ]
  })
}

# Create an alias for the KMS key
resource "aws_kms_alias" "this" {
  name          = "alias/${var.cluster_name}" # Must start with alias/
  target_key_id = aws_kms_key.this.key_id
}