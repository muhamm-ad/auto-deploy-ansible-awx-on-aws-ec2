#!/bin/bash
set -e

# Get the IMDSv2 token
TOKEN=$(curl -s -X PUT "http://169.254.169.254/latest/api/token" \
  -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

# Fetch the public hostname
PUBLIC_HOSTNAME=$(curl -s \
  -H "X-aws-ec2-metadata-token: $TOKEN" \
  http://169.254.169.254/latest/meta-data/public-hostname)

echo "PUBLIC_HOSTNAME is: $PUBLIC_HOSTNAME"

# Generate AWX configuration
cat <<EOF > /home/ubuntu/awx_setup/awx-dynamic-patch.yaml
apiVersion: awx.ansible.com/v1beta1
kind: AWX
metadata:
  name: awx
spec:
  ingress_type: ingress
  ingress_annotations: |
    kubernetes.io/ingress.class: "nginx"
    environment: testing
  ingress_hosts:
    - hostname: "$PUBLIC_HOSTNAME"
EOF

# Apply the configuration
cd /home/ubuntu/awx_setup
/usr/local/bin/kustomize build . | kubectl apply -f -

