# opencode Skills 仓库

这是一个通用的 opencode skill 仓库，包含各种可重用的 skill。

## 目录结构

```
skills/
├── example/
│   └── SKILL.md
└── [其他 skill 目录]/
    └── SKILL.md
```

## 如何使用

1. 将此仓库克隆到本地
2. 在 opencode 配置中添加 skill 路径：
   ```json
   {
     "skills": {
       "paths": ["path/to/skills/skills"]
     }
   }
   ```
3. 重启 opencode 以加载 skill

## 如何创建新 Skill

1. 在 `skills/` 目录下创建新目录
2. 在新目录中创建 `SKILL.md` 文件
3. 按照以下格式编写：

```markdown
---
name: skill-name
description: >
  Skill 描述，说明用途和触发条件。
---

# Skill 标题

Skill 内容...
```

## Skill 规范

- 目录名和 `name` 字段必须一致
- `description` 应该清晰描述 skill 的用途和触发条件
- 使用 markdown 格式编写内容
- 遵循 Conventional Commits 规范进行提交

## 贡献

欢迎贡献新的 skill！请确保：
1. 遵循上述规范
2. 添加适当的文档
3. 提交清晰的 commit message