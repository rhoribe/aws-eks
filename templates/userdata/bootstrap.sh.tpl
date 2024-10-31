MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="//"
--//
Content-Type: text/x-shellscript; charset="us-ascii"

#!/bin/bash
set -e

echo "Join to Cluster"
/etc/eks/bootstrap.sh --b64-cluster-ca '${B64_CLUSTER_CA}' --apiserver-endpoint '${APISERVER_ENDPOINT}' '${CLUSTER_ID}'

--//--
