output "id" {
  description = "ID of the IAM binding"
  value       = google_project_iam_member.this.id
}

output "etag" {
  description = "ETag of the IAM policy"
  value       = google_project_iam_member.this.etag
}
