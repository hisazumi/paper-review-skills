#!/bin/bash
#
# Paper Review Skills Installer
# Installs Claude Code skills for academic paper review
#

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILLS_SRC="$SCRIPT_DIR/skills"
SKILLS_DEST="$HOME/.claude/skills"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "======================================"
echo " Paper Review Skills Installer"
echo "======================================"
echo ""

# Check if source skills directory exists
if [ ! -d "$SKILLS_SRC" ]; then
    echo -e "${RED}Error: Skills directory not found at $SKILLS_SRC${NC}"
    exit 1
fi

# Create destination directory if it doesn't exist
if [ ! -d "$SKILLS_DEST" ]; then
    echo "Creating skills directory: $SKILLS_DEST"
    mkdir -p "$SKILLS_DEST"
fi

# List of skills to install
# BEGIN GENERATED:skills (build/build.py)
SKILLS=(
    "research-review"
    "framing-check"
    "aim-check"
    "articulation-check"
    "weakness-analyze"
    "lit-survey"
    "format-check"
    "shepherd"
    "student-comment"
    "review-tracker"
)
# END GENERATED:skills

echo "Installing skills to: $SKILLS_DEST"
echo ""

for skill in "${SKILLS[@]}"; do
    src="$SKILLS_SRC/$skill"
    dest="$SKILLS_DEST/$skill"

    if [ ! -d "$src" ]; then
        echo -e "${YELLOW}Warning: Skill not found: $skill${NC}"
        continue
    fi

    if [ -d "$dest" ] || [ -L "$dest" ]; then
        echo -e "${YELLOW}Skill already exists: $skill${NC}"
        read -p "  Overwrite? (y/N): " answer
        case "$answer" in
            [yY]|[yY][eE][sS])
                rm -rf "$dest"
                ;;
            *)
                echo "  Skipped."
                continue
                ;;
        esac
    fi

    # Copy the skill directory
    cp -r "$src" "$dest"
    echo -e "${GREEN}Installed: $skill${NC}"
done

echo ""
echo "======================================"
echo -e "${GREEN}Installation complete!${NC}"
echo "======================================"
echo ""
echo "Main:"
echo "  /research-review - 総合レビュー（概要/論文/卒論を自動判別・教員向け）"
echo "                     --student で学生向け1枚も生成"
echo "  /student-comment - 教員向けレビューを学生向け1枚に翻訳"
echo "  /format-check    - 体裁チェック（LaTeX/Word/PDF・概要は --fixed で紙面配分）"
echo "  /review-tracker  - 複数レビューの統合・追跡"
echo ""
echo "Lenses (invoked by /research-review; usable standalone):"
echo "  /framing-check /aim-check /articulation-check"
echo "  /weakness-analyze /lit-survey /shepherd"
echo ""
echo "Usage example:"
echo "  claude> /research-review path/to/abstract.tex --student"
echo ""
echo "Not using Claude Code? See the prompts/ folder — copy any .md into"
echo "ChatGPT / Gemini / any LLM and paste your document. Start with prompts/research-review.md"
echo ""
