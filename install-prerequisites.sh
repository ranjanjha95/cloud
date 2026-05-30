#!/bin/bash
set -e

echo "=========================================="
echo "Installing Prerequisites for eCommerce App"
echo "=========================================="

OS="$(uname -s)"
case "${OS}" in
    Linux*)     MACHINE=Linux;;
    Darwin*)    MACHINE=Mac;;
    *)          MACHINE="UNKNOWN:${OS}"
esac

echo "Detected OS: $MACHINE"

if [ "$MACHINE" = "Mac" ]; then
    if ! command -v brew &> /dev/null; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    command -v node &> /dev/null || brew install node@20
    command -v git &> /dev/null || brew install git
    command -v aws &> /dev/null || brew install awscli
    command -v jq &> /dev/null || brew install jq
elif [ "$MACHINE" = "Linux" ]; then
    . /etc/os-release 2>/dev/null
    DISTRO=$ID
    if [ "$DISTRO" = "ubuntu" ] || [ "$DISTRO" = "debian" ]; then
        sudo apt-get update -y
        command -v docker &> /dev/null || sudo apt-get install -y docker.io
        command -v node &> /dev/null || (curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash - && sudo apt-get install -y nodejs)
        command -v git &> /dev/null || sudo apt-get install -y git
        command -v jq &> /dev/null || sudo apt-get install -y jq
        command -v aws &> /dev/null || (curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && sudo apt-get install -y unzip && unzip awscliv2.zip && sudo ./aws/install && rm -rf aws awscliv2.zip)
    elif [ "$DISTRO" = "amzn" ] || [ "$DISTRO" = "rhel" ] || [ "$DISTRO" = "centos" ]; then
        sudo yum update -y
        command -v docker &> /dev/null || (sudo yum install -y docker && sudo systemctl start docker && sudo systemctl enable docker)
        command -v node &> /dev/null || (curl -fsSL https://rpm.nodesource.com/setup_20.x | sudo bash - && sudo yum install -y nodejs)
        command -v git &> /dev/null || sudo yum install -y git
        command -v jq &> /dev/null || sudo yum install -y jq
        command -v aws &> /dev/null || sudo yum install -y aws-cli
    fi
fi

echo ""
echo "=========================================="
echo "Installation Complete!"
echo "=========================================="
