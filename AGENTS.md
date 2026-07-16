# AGENTS.md - Skill 仓库指南

## 项目概述

这是一个 opencode skill 仓库，用于存储和管理可重用的 skill。

## 快速开始

1. **添加 skill 路径**：在 opencode 配置中添加：
   ```json
   {
     "skills": {
       "paths": ["path/to/skills/skills"]
     }
   }
   ```

2. **创建新 skill**：
   - 在 `skills/` 下创建目录
   - 添加 `SKILL.md` 文件
   - 遵循 frontmatter 格式

## 关键规范

- **目录名 = skill 名称**：目录名必须与 `SKILL.md` 中的 `name` 字段一致
- **description 必填**：清晰描述 skill 用途和触发条件
- **Markdown 格式**：使用标准 markdown 编写内容

## 文件结构

```
skills/
├── example/
│   └── SKILL.md
└── [skill-name]/
    └── SKILL.md
```

## 提交规范

使用 Conventional Commits 格式：
- `feat: 新增 xxx skill`
- `fix: 修复 xxx skill 问题`
- `docs: 更新 xxx 文档`