#!/bin/bash

# Skill 安装脚本
# 用于将本仓库中的 skill 安装到指定项目

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 使用说明
usage() {
    echo -e "${GREEN}用法:${NC}"
    echo "  $0 <skill-name> [target-dir]"
    echo "  $0 --list"
    echo "  $0 --all [target-dir]"
    echo ""
    echo -e "${GREEN}参数:${NC}"
    echo "  skill-name    要安装的 skill 名称"
    echo "  target-dir    目标目录（可选，默认为当前目录）"
    echo ""
    echo -e "${GREEN}选项:${NC}"
    echo "  --list        列出所有可用的 skill"
    echo "  --all         安装所有 skill"
    echo "  --help        显示此帮助信息"
    echo ""
    echo -e "${GREEN}示例:${NC}"
    echo "  $0 git-commit                    # 安装到当前目录"
    echo "  $0 git-commit /path/to/project   # 安装到指定目录"
    echo "  $0 --list                         # 列出所有 skill"
    echo "  $0 --all                          # 安装所有 skill 到当前目录"
}

# 列出所有可用的 skill
list_skills() {
    echo -e "${GREEN}可用的 skill:${NC}"
    echo ""
    local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local skills_dir="$script_dir/skills"
    
    if [ -d "$skills_dir" ]; then
        for skill in "$skills_dir"/*/; do
            if [ -d "$skill" ] && [ -f "$skill/SKILL.md" ]; then
                local skill_name=$(basename "$skill")
                local description=$(grep -A1 "description:" "$skill/SKILL.md" | tail -1 | sed 's/^  *//' | sed 's/>-//')
                echo -e "  ${YELLOW}$skill_name${NC}"
                echo "    $description"
                echo ""
            fi
        done
    else
        echo -e "${RED}错误: 找不到 skills 目录${NC}"
        exit 1
    fi
}

# 安装单个 skill
install_skill() {
    local skill_name="$1"
    local target_dir="${2:-.}"
    local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local source_dir="$script_dir/skills/$skill_name"
    local dest_dir="$target_dir/.opencode/skills/$skill_name"
    
    # 检查 skill 是否存在
    if [ ! -d "$source_dir" ]; then
        echo -e "${RED}错误: 找不到 skill '$skill_name'${NC}"
        echo "使用 --list 查看可用的 skill"
        exit 1
    fi
    
    if [ ! -f "$source_dir/SKILL.md" ]; then
        echo -e "${RED}错误: skill '$skill_name' 缺少 SKILL.md 文件${NC}"
        exit 1
    fi
    
    # 创建目标目录
    mkdir -p "$dest_dir"
    
    # 复制文件
    cp -r "$source_dir"/* "$dest_dir/"
    
    echo -e "${GREEN}✓ 已安装 skill '$skill_name'${NC}"
    echo "  目标位置: $dest_dir"
}

# 安装所有 skill
install_all() {
    local target_dir="${1:-.}"
    local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local skills_dir="$script_dir/skills"
    
    if [ ! -d "$skills_dir" ]; then
        echo -e "${RED}错误: 找不到 skills 目录${NC}"
        exit 1
    fi
    
    echo -e "${GREEN}安装所有 skill...${NC}"
    echo ""
    
    for skill in "$skills_dir"/*/; do
        if [ -d "$skill" ] && [ -f "$skill/SKILL.md" ]; then
            local skill_name=$(basename "$skill")
            install_skill "$skill_name" "$target_dir"
            echo ""
        fi
    done
    
    echo -e "${GREEN}✓ 所有 skill 安装完成${NC}"
}

# 主函数
main() {
    if [ $# -eq 0 ]; then
        usage
        exit 0
    fi
    
    case "$1" in
        --help|-h)
            usage
            ;;
        --list|-l)
            list_skills
            ;;
        --all|-a)
            install_all "$2"
            ;;
        *)
            install_skill "$1" "$2"
            ;;
    esac
}

main "$@"