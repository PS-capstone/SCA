# SCA - 통합 학습 관리 시스템

학생과 교사를 위한 게이미피케이션 기반 통합 학습 관리 플랫폼입니다.

## 프로젝트 개요

SCA(Smart Community Academy)는 학생의 학습 동기를 부여하고 교사의 학습 관리를 효율화하기 위해 개발된 웹 애플리케이션입니다. 게이미피케이션 요소(퀘스트, 가챠, 레이드)를 활용하여 학습 과정을 재미있고 체계적으로 관리할 수 있습니다.

## 주요 기능

### 학생 기능
- **퀘스트 시스템**: 교사가 제시한 과제를 수행하고 보상(코랄, 탐사 데이터) 획득
- **가챠 시스템**: 획득한 코랄로 물고기 가챠를 뽑아 컬렉션 수집
- **레이드 시스템**: 반 전체가 협력하여 보스 레이드에 참여하고 보상 획득
- **도감 시스템**: 수집한 물고기를 확인하고 관리
- **대시보드**: 개인 진도, 성취도, 보유 재화 확인

### 교사 기능
- **클래스 관리**: 학급 생성, 학생 초대 및 관리
- **퀘스트 관리**: 과제 생성, 난이도 설정, 제출물 승인/반려
- **레이드 관리**: 반 단위 레이드 생성 및 모니터링
- **학생 모니터링**: 학생별 진도, 성적, 활동 내역 조회
- **성적 분석**: 반 전체 및 개별 학생 성적 통계 및 분석

## 기술 스택

| 분류 | 기술 스택 |
| :--- | :--- |
| **Frontend** | ![React](https://img.shields.io/badge/React_18-20232A?style=flat-square&logo=react&logoColor=61DAFB) ![TypeScript](https://img.shields.io/badge/TypeScript-3178C6?style=flat-square&logo=typescript&logoColor=white) ![Vite](https://img.shields.io/badge/Vite-646CFF?style=flat-square&logo=vite&logoColor=white) ![Tailwind CSS](https://img.shields.io/badge/Tailwind_CSS-06B6D4?style=flat-square&logo=tailwindcss&logoColor=white) |
| **Backend** | ![Spring Boot](https://img.shields.io/badge/Spring_Boot_3.x-6DB33F?style=flat-square&logo=springboot&logoColor=white) ![Spring Security](https://img.shields.io/badge/Spring_Security-6DB33F?style=flat-square&logo=springsecurity&logoColor=white) ![MySQL](https://img.shields.io/badge/MySQL_8.0-4479A1?style=flat-square&logo=mysql&logoColor=white) |
| **Infra** | ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white) ![AWS S3](https://img.shields.io/badge/AWS_S3-569A31?style=flat-square&logo=amazons3&logoColor=white) ![Nginx](https://img.shields.io/badge/Nginx-009639?style=flat-square&logo=nginx&logoColor=white) |
| **DevOps** | ![Git](https://img.shields.io/badge/Git-F05032?style=flat-square&logo=git&logoColor=white) ![Gradle](https://img.shields.io/badge/Gradle-02303A?style=flat-square&logo=gradle&logoColor=white) |

### Frontend
- **React 18**: 컴포넌트 기반 UI 개발
- **TypeScript**: 타입 안정성 보장
- **Vite**: 빠른 개발 서버 및 빌드 도구
- **Tailwind CSS**: 유틸리티 기반 스타일링
- **Radix UI**: 접근성 높은 UI 컴포넌트
- **React Router**: 클라이언트 사이드 라우팅

### Backend
- **Spring Boot 3.x**: RESTful API 서버
- **Groovy**: 동적 타입 언어 활용
- **Spring Security**: JWT 기반 인증 및 권한 관리
- **Spring Data JPA**: 데이터베이스 ORM
- **HikariCP**: 커넥션 풀 관리
- **MySQL 8.0**: 관계형 데이터베이스

### Infrastructure
- **Docker**: 컨테이너화
- **Docker Compose**: 멀티 컨테이너 애플리케이션 관리
- **Nginx**: 프론트엔드 정적 파일 서빙 및 리버스 프록시
- **AWS S3**: 파일 저장소 (선택적)

### DevOps
- **Git**: 버전 관리
- **Gradle**: 빌드 자동화
- **배포 스크립트**: 자동화된 배포 프로세스

## 프로젝트 구조

```
SCA/
├── SCA-FE/                 # React 프론트엔드
│   ├── src/
│   │   ├── components/    # 컴포넌트
│   │   │   ├── student/   # 학생용 컴포넌트
│   │   │   ├── teacher/   # 교사용 컴포넌트
│   │   │   └── ui/        # 공통 UI 컴포넌트
│   │   ├── contexts/      # React Context
│   │   ├── routes/        # 라우팅 설정
│   │   └── utils/         # 유틸리티 함수
│   ├── Dockerfile
│   └── package.json
│
├── SCA-BE/                # Spring Boot 백엔드
│   ├── src/main/groovy/
│   │   └── com/example/sca_be/
│   │       ├── domain/           # 도메인별 패키지
│   │       │   ├── ai/           # ai 보상 추천 로직
│   │       │   ├── auth/         # 로그인 및 JWT 인증
│   │       │   ├── classroom/    # 학급 관리
│   │       │   ├── gacha/        # 확률형 아이템(가챠) 로직
│   │       │   ├── groupquest/   # 단체퀘스트 CRUD 및 상태 관리
│   │       │   ├── notification/ # 공지 기능
│   │       │   ├── personalquest/# 개인퀘스트 CRUD 및 상태 관리
│   │       │   └── raid/         # 협동 레이드 로직
│   │       ├── global/    # 전역 설정
│   │       └── ScaBeApplication.groovy
│   ├── src/main/resources/
│   │   ├── application.yaml
│   │   └── schema-h2.sql
│   ├── Dockerfile
│   └── build.gradle
│
├── docker-compose.yml     # Docker Compose 설정
├── sca_V2.sql            # 데이터베이스 초기화 스크립트
└── deploy.sh             # 배포 스크립트
```

## 설치 및 실행

### 사전 요구사항
- Docker 및 Docker Compose
- Java 17 이상 (로컬 개발용)
- Node.js 18 이상 (로컬 개발용)

### Docker Compose를 이용한 실행

1. 저장소 클론
```bash
git clone https://github.com/PS-capstone/SCA.git
cd SCA
```

2. 환경 변수 설정
```bash
# .env 파일 생성 (필요한 경우)
cp .env.example .env
# .env 파일에 필요한 환경 변수 설정
```

3. Docker Compose로 실행
```bash
docker compose up -d
```

4. 접속
- Frontend: http://localhost
- Backend API: http://localhost:8080
- MySQL: localhost:3306

### 로컬 개발 환경 설정

#### Backend (Spring Boot)
```bash
cd SCA-BE
./gradlew bootRun
```

#### Frontend (React)
```bash
cd SCA-FE
npm install
npm run dev
```

## API 문서

### 인증
- `POST /api/v1/auth/login` - 로그인
- `POST /api/v1/auth/signup` - 회원가입
- `POST /api/v1/auth/refresh` - 토큰 갱신

### 학생 API
- `GET /api/v1/quests/my-quests` - 내 퀘스트 목록
- `POST /api/v1/quests/{questId}/submit` - 퀘스트 제출
- `GET /api/v1/gacha/info` - 가챠 정보 조회
- `POST /api/v1/gacha/draw` - 가챠 뽑기
- `GET /api/v1/collection/aquarium` - 수족관 조회
- `GET /api/v1/collection/encyclopedia` - 도감 조회
- `GET /api/v1/raids/my-raid` - 내 레이드 조회
- `POST /api/v1/raids/{raidId}/attack` - 레이드 공격

### 교사 API
- `GET /api/v1/classes` - 클래스 목록
- `POST /api/v1/classes` - 클래스 생성
- `POST /api/v1/quests` - 퀘스트 생성
- `GET /api/v1/quests/{questId}/submissions` - 제출물 목록
- `POST /api/v1/quests/{questId}/approve` - 제출물 승인
- `POST /api/v1/raids` - 레이드 생성
- `GET /api/v1/students/{studentId}/progress` - 학생 진도 조회

## 데이터베이스 스키마

주요 테이블:
- `members`: 회원 정보
- `students`: 학생 정보 및 재화
- `teachers`: 교사 정보
- `classes`: 학급 정보
- `quests`: 퀘스트 정보
- `submissions`: 제출물 정보
- `fish`: 물고기 마스터 데이터
- `collections`: 학생 도감
- `raids`: 레이드 정보
- `raid_logs`: 레이드 로그

자세한 스키마는 `sca_V2.sql` 파일을 참고하세요.

## 주요 기술적 특징

### 인증 및 보안
- JWT 기반 인증 시스템
- Access Token 및 Refresh Token 분리
- Spring Security를 통한 역할 기반 접근 제어 (RBAC)

### 게이미피케이션
- 확률 기반 가챠 시스템 (COMMON, RARE, LEGENDARY 등급)
- 퀘스트 난이도별 보상 차등화
- 레이드 협력 시스템

### 실시간 통신
- WebSocket을 통한 레이드 로그 실시간 방송
- 학생들의 레이드 참여 상황 실시간 업데이트

### 데이터 분석
- 학생별 학습 보정 계수 시스템
- 난이도별 학습 횟수 및 성취도 추적
- AI 학습 로그 기록

## 배포

배포 스크립트를 사용하여 서버에 배포할 수 있습니다.

```bash
./deploy.sh
```

배포 스크립트는 다음 작업을 수행합니다:
1. 로컬에서 백엔드 및 프론트엔드 빌드
2. 빌드 결과물을 서버로 전송
3. 서버에서 Docker 이미지 빌드 및 컨테이너 실행

## 개발 환경

- **개발 언어**: Java, Groovy, TypeScript
- **프레임워크**: Spring Boot, React
- **데이터베이스**: MySQL (프로덕션), H2 (개발)
- **빌드 도구**: Gradle, Vite
- **컨테이너**: Docker, Docker Compose

## 라이선스

이 프로젝트는 교육 목적으로 개발되었습니다.

## 기여자

PS-capstone 팀

## 참고사항

- 프로덕션 환경에서는 반드시 환경 변수를 안전하게 관리하세요
- 데이터베이스 백업을 정기적으로 수행하세요
- API 키 및 비밀번호는 절대 공개 저장소에 커밋하지 마세요

