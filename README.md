# OrderFlow

This repository contains the Release Readiness Investigation & Deployment Approval Lab.

## Application

A simple Node.js Express application.

### Endpoints
- `GET /`
- `GET /health`
## Current Release
v2.3.0
Production Deployment

## Getting Started

### Clone
```bash
git clone https://github.com/kalvium-devops/release-readiness-lab.git
cd release-readiness-lab
```

### Install
```bash
cd app
npm install
```

### Run
```bash
npm start
```
Alternatively, use Docker Compose:
```bash
docker-compose up --build
```

### Push
Make your changes and push them back to the repository.

## Repository Structure
```
├── .github/
│   └── workflows/
│       └── release.yml
├── app/
│   ├── server.js
│   └── package.json
├── deployment/
│   ├── kubernetes/
│   └── terraform/
├── release/
│   ├── approvals.yml
│   ├── deployment-config.yml
│   ├── release-summary.yml
│   ├── release.json
│   ├── rollback.yml
│   └── RELEASE_READINESS.md
├── scripts/
│   ├── deploy.sh
│   └── rollback.sh
├── Dockerfile
├── docker-compose.yml
└── README.md
```

## Release Readiness Pack
Operational documentation and release governance artifacts are available in the `release/` directory:
- **Release Version**: `v2.3.0` documented in [release.json](release/release.json) and [release-summary.yml](release/release-summary.yml)
- **Deployment Strategy**: Rolling update with zero downtime
- **Rollback Strategy**: Automated rollback to `v2.2.0` defined in [rollback.yml](release/rollback.yml) and [scripts/rollback.sh](scripts/rollback.sh)
- **Infrastructure Decision**: Kubernetes container orchestration selected over standalone EC2 for resilience and scalability
- **Approval Checklist**: Production sign-off recorded in [approvals.yml](release/approvals.yml)
- **Validation Summary**: Validation tests execute before deployment in `.github/workflows/release.yml`
