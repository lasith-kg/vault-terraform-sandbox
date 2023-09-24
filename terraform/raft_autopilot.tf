resource "vault_raft_autopilot" "autopilot" {
  cleanup_dead_servers = true
  dead_server_last_contact_threshold = "1m"
  last_contact_threshold = "15s"
  max_trailing_logs = 1000
  min_quorum = 3
  server_stabilization_time = "10s"
}
