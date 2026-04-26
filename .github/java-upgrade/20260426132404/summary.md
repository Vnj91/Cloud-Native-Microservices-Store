# Security Fix Results (20260426132404)

- **Project**: devops-store
- **Completed**: 2026-04-26T13:28:00Z
- **Duration**: 4m
- **Build attempts**: 2 (2 succeeded)
- **Plan**: `.github/java-upgrade/20260426132404/plan.md`

## CVE Results

| # | CVE | Dependency | Status |
|---|-----|------------|--------|
| 1 | [CVE-2026-22731](https://github.com/advisories/GHSA-8hfc-fq58-r658) | org.springframework.boot:spring-boot-starter-actuator | ✅ Fixed (4.0.3 → 4.0.6) |
| 2 | [CVE-2026-22733](https://github.com/advisories/GHSA-mgvc-8q2h-5pgc) | org.springframework.boot:spring-boot-starter-actuator | ✅ Fixed (4.0.3 → 4.0.6) |

## Summary

- **Build status**: ✅ Passing
- **CVEs fixed**: 2/2
- **Deprecated API usages fixed**: 0/0

## Changes Made

- `product-service/pom.xml`: updated `spring-boot-starter-parent` version to `4.0.6`
- `user-service/pom.xml`: updated `spring-boot-starter-parent` version to `4.0.6`
