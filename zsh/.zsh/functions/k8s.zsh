alias k="command kubectl"

function kdash() {
  command kubectl -n kubernetes-dashboard create token admin-user | pbcopy
  command kubectl -n kubernetes-dashboard port-forward svc/kubernetes-dashboard-kong-proxy 8443:443
}

