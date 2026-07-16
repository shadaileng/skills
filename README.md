# opencode Skills 仓库

这是一个通用的 opencode skill 仓库，包含各种可重用的 skill。

## 目录结构

```
skills/
├── example/
│   └── SKILL.md
├── git-commit/
│   └── SKILL.md
├── docs-manage/
│   └── SKILL.md
├── typescript-conventions/
│   └── SKILL.md
└── wechat-article-style/
    └── SKILL.md
```

## 快速安装

### 方法 1：使用安装脚本（推荐）

**Linux/macOS:**
```bash
# 安装单个 skill
chmod +x install.sh
./install.sh git-commit /path/to/your/project

# 安装所有 skill
./install.sh --all /path/to/your/project

# 查看可用的 skill
./install.sh --list
```

**Windows (CMD):**
```cmd
# 安装单个 skill
install.bat git-commit C:\path\to\your\project

# 安装所有 skill
install.bat --all C:\path\to\your\project

# 查看可用的 skill
install.bat --list
```

**Windows (PowerShell):**
```powershell
# 安装单个 skill
.\install.ps1 -SkillName "git-commit" -TargetDir "C:\path\to\your\project"

# 安装所有 skill
.\install.ps1 -All -TargetDir "C:\path\to\your\project"

# 查看可用的 skill
.\install.ps1 -List
```

### 方法 2：手动复制

将需要的 skill 目录复制到项目的 `.opencode/skills/` 目录下：

```bash
# 创建目录
mkdir -p .opencode/skills

# 复制 skill
cp -r /path/to/skills/skills/git-commit .opencode/skills/
```

### 方法 3：配置共享路径

在 opencode 配置中添加 skill 仓库路径：

```json
{
  "skills": {
    "paths": ["/path/to/skills/skills"]
  }
}
```

## 如何使用

1. 将此仓库克隆到本地
2. 使用安装脚本或手动复制 skill 到项目
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

## 可用的 Skill

| Skill | 说明 |
|-------|------|
| `example` | 示例 skill，展示标准结构 |
| `git-commit` | Git 提交规范 |
| `docs-manage` | 文档管理规范 |
| `typescript-conventions` | TypeScript 编码规范 |
| `wechat-article-style` | 微信公众号文章风格 |

## 贡献

欢迎贡献新的 skill！请确保：
1. 遵循上述规范
2. 添加适当的文档
3. 提交清晰的 commit message