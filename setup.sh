#!/bin/bash
# setup code server
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
# install docker as required for testcontainers
curl https://get.docker.com | sudo bash
sudo gpasswd -a student docker
sudo apt-get update
# install common dependencies
sudo apt-get install -y git less groff unzip python3 python3-pip python3-venv
# install ansible
sudo apt-add-repository -y ppa:ansible/ansible
sudo apt-get update
sudo apt-get install -y ansible
ansible-galaxy collection install amazon.aws
# install aws and antigravity CLIs
curl -fsSL https://awscli.amazonaws.com/v2/install.sh | bash
curl -fsSL https://antigravity.google/cli/install.sh | bash
# add typical aws binary location to path
echo "export PATH=$PATH:$HOME/.local/bin" | tee -a $HOME/.bashrc
# install postgres CLI
sudo apt-get install -y postgresql-client
