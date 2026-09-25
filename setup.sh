#!/bin/bash
cat > install-code.sh << 'EOF'
curl -fsSL https://code-server.dev/install.sh | sh
sudo systemctl enable --now code-server@$USER
sleep 10
sed -i.bak 's/127.0.0.1/0.0.0.0/' ~/.config/code-server/config.yaml
sudo systemctl restart code-server@$USER
echo "Point your browser at http://$(curl ifconfig.io):8080"
EOF

chmod +x install-code.sh
. install-code.sh
sudo apt-get install -y less groff unzip python3 python3-pip python3-venv
sudo apt-add-repository -y ppa:ansible/ansible
sudo apt-get update
sudo apt-get install ansible
ansible-galaxy collection install amazon.aws
curl -fsSL https://awscli.amazonaws.com/v2/install.sh | bash
curl -fsSL https://antigravity.google/cli/install.sh | bash
echo "export PATH=$PATH:$HOME/.local/bin" | tee -a $HOME/.bashrc
sudo apt-get install -y postgresql-client-18
