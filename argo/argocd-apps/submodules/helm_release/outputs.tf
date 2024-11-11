output "chart_release" {
  description = "Status of the deployed release."
  value       = helm_release.this[*].metadata
}
