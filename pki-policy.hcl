path "intermediate_ca/issue/*" {
  capabilities = ["create", "update"]
}

path "intermediate_ca/cert/ca" {
  capabilities = ["read"]
}

path "intermediate_ca/roles/*" {
  capabilities = ["read"]
}
