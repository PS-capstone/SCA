#!/bin/bash

# 배포 스크립트
# 사용법: ./deploy.sh

set -e

SERVER_IP="52.62.22.54"
SERVER_USER="ubuntu"
KEY_PATH="$HOME/Downloads/sca-key.pem"
PROJECT_DIR="/home/ubuntu/sea_V2"
GIT_REPO_BE="https://github.com/PS-capstone/SCA-BE.git"
GIT_REPO_FE="https://github.com/PS-capstone/SCA-FE.git"
BE_BRANCH="jin/fix/after_1203"
FE_BRANCH="yw/demo"

echo "🚀 배포 시작..."

# 서버에서 Git에서 코드를 받아서 빌드 및 배포
echo "🔨 서버에서 Git pull 및 배포 실행 중..."
ssh -i $KEY_PATH -o StrictHostKeyChecking=no $SERVER_USER@$SERVER_IP << 'ENDSSH'
cd /home/ubuntu

# 도커 설치 확인 및 설치
if ! command -v docker &> /dev/null; then
    echo "🐳 도커 설치 중..."
    sudo apt-get update
    sudo apt-get install -y ca-certificates curl gnupg lsb-release
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
    sudo usermod -aG docker $USER
    echo "✅ 도커 설치 완료"
else
    echo "✅ 도커가 이미 설치되어 있습니다"
fi

# docker-compose 설치 확인 (별도 설치가 필요한 경우)
if ! command -v docker-compose &> /dev/null && ! docker compose version &> /dev/null; then
    echo "🐳 docker-compose 설치 중..."
    sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    echo "✅ docker-compose 설치 완료"
else
    echo "✅ docker-compose가 이미 설치되어 있습니다"
fi

# Java 설치 확인 및 설치
if ! command -v java &> /dev/null; then
    echo "☕ Java 설치 중..."
    sudo apt-get update
    sudo apt-get install -y openjdk-17-jdk
    echo "✅ Java 설치 완료"
else
    echo "✅ Java가 이미 설치되어 있습니다"
    java -version
fi

# docker compose 명령어 확인 (docker compose 또는 docker-compose)
if docker compose version &> /dev/null; then
    DOCKER_COMPOSE_CMD="docker compose"
elif command -v docker-compose &> /dev/null; then
    DOCKER_COMPOSE_CMD="docker-compose"
else
    DOCKER_COMPOSE_CMD="sudo docker compose"
fi

# 도커 그룹 적용 (새로 설치한 경우)
if ! groups | grep -q docker; then
    echo "🔧 도커 그룹 적용 중..."
    sudo usermod -aG docker $USER
fi

# 도커 이미지 빌드 및 배포 (MySQL 포함)
echo "🐳 도커 이미지 빌드 중 (MySQL 포함)..."
sudo $DOCKER_COMPOSE_CMD build

echo "🔄 기존 컨테이너 중지 및 제거..."
sudo $DOCKER_COMPOSE_CMD down

echo "🚀 새 컨테이너 시작 (MySQL, Backend, Frontend)..."
sudo $DOCKER_COMPOSE_CMD up -d

echo "✅ 배포 완료!"
sudo $DOCKER_COMPOSE_CMD ps
ENDSSH

echo "🎉 배포가 완료되었습니다!"







