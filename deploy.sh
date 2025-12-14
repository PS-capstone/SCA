#!/bin/bash

# 배포 스크립트
# 사용법: ./deploy.sh

set -e

SERVER_IP="52.62.22.54"
SERVER_USER="ubuntu"
KEY_PATH="$HOME/Downloads/sca-key.pem"
PROJECT_DIR="/home/ubuntu/sea_V2"

echo "🚀 배포 시작..."

# 1. 로컬에서 백엔드 빌드
echo "📦 로컬에서 백엔드 빌드 중..."
cd SCA-BE
if [ ! -f "./gradlew" ]; then
    echo "❌ gradlew 파일을 찾을 수 없습니다."
    exit 1
fi
./gradlew clean build -x test
if [ ! -f "./build/libs/sca-be-0.0.1-SNAPSHOT.jar" ]; then
    echo "❌ 빌드 실패: JAR 파일이 생성되지 않았습니다."
    exit 1
fi
echo "✅ 백엔드 빌드 완료"
cd ..

# 2. 로컬에서 프론트엔드 빌드
echo "📦 로컬에서 프론트엔드 빌드 중..."
cd SCA-FE
if [ ! -f "./package.json" ]; then
    echo "❌ package.json 파일을 찾을 수 없습니다."
    exit 1
fi
npm install
npm run build
if [ ! -d "./build" ]; then
    echo "❌ 빌드 실패: build 디렉토리가 생성되지 않았습니다."
    exit 1
fi
echo "✅ 프론트엔드 빌드 완료"
cd ..

# 3. 서버에 필요한 파일만 전송
echo "📦 서버에 파일 전송 중..."
rsync -avz --exclude 'node_modules' \
           --exclude '.git' \
           --exclude 'SCA-BE/.gradle' \
           --exclude 'SCA-BE/data' \
           --exclude 'SCA-BE/build/classes' \
           --exclude 'SCA-BE/build/generated' \
           --exclude 'SCA-BE/build/reports' \
           --exclude 'SCA-BE/build/tmp' \
           --exclude 'SCA-BE/build/resources' \
           --include 'SCA-BE/build/libs/*.jar' \
           --include 'SCA-FE/build/**' \
           --include 'docker-compose.yml' \
           --include 'SCA-BE/Dockerfile' \
           --include 'SCA-FE/Dockerfile' \
           --include 'SCA-FE/nginx.conf' \
           --include 'sca_V2.sql' \
           -e "ssh -i $KEY_PATH -o StrictHostKeyChecking=no" \
           ./ $SERVER_USER@$SERVER_IP:$PROJECT_DIR/

# 4. 서버에서 도커 배포
echo "🔨 서버에서 도커 배포 실행 중..."
ssh -i $KEY_PATH -o StrictHostKeyChecking=no $SERVER_USER@$SERVER_IP << 'ENDSSH'
cd /home/ubuntu/sea_V2

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

# docker compose 명령어 확인
if docker compose version &> /dev/null; then
    DOCKER_COMPOSE_CMD="sudo docker compose"
elif command -v docker-compose &> /dev/null; then
    DOCKER_COMPOSE_CMD="sudo docker-compose"
else
    echo "❌ docker-compose를 찾을 수 없습니다."
    exit 1
fi

# 도커 그룹 적용
if ! groups | grep -q docker; then
    echo "🔧 도커 그룹 적용 중..."
    sudo usermod -aG docker $USER
fi

# 도커 이미지 빌드 및 배포
echo "🐳 도커 이미지 빌드 중 (MySQL 포함)..."
$DOCKER_COMPOSE_CMD build

echo "🔄 기존 컨테이너 중지 및 제거..."
$DOCKER_COMPOSE_CMD down

echo "🚀 새 컨테이너 시작 (MySQL, Backend, Frontend)..."
$DOCKER_COMPOSE_CMD up -d

echo "✅ 배포 완료!"
$DOCKER_COMPOSE_CMD ps
ENDSSH

echo "🎉 배포가 완료되었습니다!"
