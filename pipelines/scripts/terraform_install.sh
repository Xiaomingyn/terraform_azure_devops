#!/usr/bin/env bash
set -euo pipefail
TERRAFORM_VERSION="1.9.8"
curl -fsSL "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" -o terraform.zip
python - <<'PY'
import zipfile
with zipfile.ZipFile('terraform.zip') as z:
    z.extractall('.')
PY
chmod +x terraform
mkdir -p "$HOME/bin"
mv terraform "$HOME/bin/terraform"
export PATH="$HOME/bin:$PATH"
terraform version
