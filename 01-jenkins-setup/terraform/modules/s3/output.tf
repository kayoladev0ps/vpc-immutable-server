output "region"{
    value = var.region
}
output "project_name"{
    value = var.project_name
}
output "environment"{
    value = var.environment
}
output "bucket"{
    value = aws_s3_bucket.mys3-project.id
}