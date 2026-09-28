# OrderFlow v2.3.0 — Release Readiness Pack

## 1. Release Version Information
- **Application**: OrderFlow
- **Release Version**: `v2.3.0`
- **Previous Stable Version**: `v2.2.0`
- **Release Date**: 2026-09-28
- **Container Image**: `lab-app:v2.3.0`
- **Release Author**: DevOps Team

## 2. Deployment Strategy
- **Strategy Type**: Rolling Update (`RollingUpdate`)
- **Zero Downtime**: Enabled
- **Configuration**:
  - `maxSurge`: 1 (25-33% surge)
  - `maxUnavailable`: 0 (guarantees minimum 3 healthy pods at all times)
- **Health Probes**:
  - Liveness probe on `/health` (port 3000)
  - Readiness probe on `/health` (port 3000)

## 3. Rollback Strategy
- **Rollback Type**: Automated Rolling Rollback
- **Target Rollback Version**: `v2.2.0`
- **Triggers**:
  - Unhealthy pod restarts exceeding threshold
  - Health check endpoint `/health` returning non-200 responses
  - High error rate (> 1% 5xx responses)
- **Rollback Execution**:
  - Kubernetes command: `kubectl rollout undo deployment/lab-app`
  - Automated script: `scripts/rollback.sh v2.2.0`

## 4. Deployment Infrastructure Decision
- **Selected Platform**: **Kubernetes** (`deployment/kubernetes/`)
  - 3 pod replicas distributed across nodes
  - Service type: `LoadBalancer` mapping port 80 to container port 3000
  - Native secret injection via `secretKeyRef`
- **Decision Rationale**:
  - The application is containerized with Docker.
  - A standalone AWS EC2 instance (`t2.micro` in Terraform) represents a Single Point of Failure (SPOF) with no self-healing, auto-scaling, or zero-downtime rolling updates.
  - Kubernetes provides automated container health checks, self-healing pod restarts, and zero-downtime rolling deployments.

## 5. Production Approval Checklist
- [x] Code review and peer sign-off complete
- [x] Automated test suite passed (`npm test --prefix app`)
- [x] Secret sanitization verified (no hardcoded passwords or API keys in repository)
- [x] Environment protection and branch rules enforced
- [x] Rollback plan and script verified
- **Approved by**: DevOps Lead
- **Release Manager**: Release Manager
- **Status**: APPROVED for Production

## 6. Deployment Validation Summary
- **Validation Pipeline**: `.github/workflows/release.yml`
- **Pipeline Stage Order**: Validation (`validate-release`) executes and must pass before Deployment (`deploy-production`)
- **Test Command**: `npm test --prefix app`
- **Health Check Endpoint**: `GET /health` -> `{"status":"ok","version":"1.0.0"}`
- **Verdict**: **PRODUCTION READY**
