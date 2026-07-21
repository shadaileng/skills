# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.6.0] - 2026-07-21

### Added

- VitePress 文档站点（docs 目录），含导航栏、侧边栏、首页布局
- `docs:dev` / `docs:build` / `docs:preview` 脚本命令
- CloudStudio 代理兼容性配置（`--host 0.0.0.0` + `server.allowedHosts`）
- VitePress 文档系统执行方案（`docs/plans/02-VitePress文档系统执行方案.md`）
- 后端测试套件：Admin API 测试（8 用例）、Match API 测试（4 用例）、性能基准测试（3 用例）、WebSocket 测试（3 用例，需运行服务器）
- 前端 Playwright E2E 测试套件：首页/房间/排行榜/战绩/导航共 9 个测试用例，含 Three.js 3D Canvas 渲染验证和 ECharts 图表验证

## [0.5.0] - 2026-07-19

### Added

- Web 前端模块（Vue 3 + Three.js 3D 可视化）
- Python 后端模块（FastAPI + Socket.IO、认证、房间、动作识别、WebSocket）
- 微信小程序模块（传感器数据采集、API/Socket 服务）
- 管理后台模块（仪表盘、用户管理、房间管理）
- Docker 容器化配置（Dockerfile + Nginx）
- FBX 转 GLB 工具脚本
- 项目根配置（pnpm monorepo、环境变量模板、OpenCode skill）
- 项目文档模块（架构、指南、执行方案）
- 项目 README 和 AGENTS 文档
