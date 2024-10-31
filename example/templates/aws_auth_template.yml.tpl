- rolearn:  ${role_cluster}
  username: system:node:{{EC2PrivateDNSName}}
  groups:
  - system:bootstrappers
  - system:nodes
  - system:node-proxier
- rolearn:  ${role_cluster}
  username: system:node:{{SessionName}}
  groups:
  - system:bootstrappers
  - system:nodes
  - system:node-proxier