#!/bin/bash

# 디스크 공간 확인 스크립트
# 사용법: ./check-disk-space.sh

echo "=========================================="
echo "📊 디스크 공간 확인"
echo "=========================================="
echo ""

echo "1️⃣ 전체 파일 시스템 사용량:"
df -h
echo ""

echo "2️⃣ 현재 디렉토리 용량:"
du -sh .
echo ""

echo "3️⃣ Docker 디스크 사용량:"
docker system df
echo ""

echo "4️⃣ Docker 이미지 용량:"
docker images --format "table {{.Repository}}\t{{.Tag}}\t{{.Size}}" | head -10
echo ""

echo "5️⃣ 실행 중인 컨테이너 용량:"
docker ps -s
echo ""

echo "6️⃣ Docker 볼륨 용량:"
docker volume ls
echo ""

echo "7️⃣ 큰 디렉토리 Top 10:"
du -h --max-depth=1 . 2>/dev/null | sort -hr | head -10
echo ""

echo "=========================================="
echo "✅ 확인 완료"
echo "=========================================="

