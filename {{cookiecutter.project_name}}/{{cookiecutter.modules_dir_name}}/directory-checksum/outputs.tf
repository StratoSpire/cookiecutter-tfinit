output "checksum" {
  description = "Checksum of the directory"
  value       = data.external.checksum.result["checksum"]
}
