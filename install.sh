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
SKILLS=(
    "check-articulation"
    "format-check"
    "review"
    "review-analyze"
    "review-shepherd"
    "review-tracker"
    "survey-literature"
    "thesis-review"
)

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
echo "Available skills:"
echo "  /check-articulation - Detect missing explanations (5W analysis)"
echo "  /review             - Full auto-review (thesis or paper)"
echo "  /format-check       - Format & style check (LaTeX / Word)"
echo "  /review-tracker     - Merge & track multiple reviews"
echo ""
echo "Advanced (internal, also standalone):"
echo "  /review-analyze     - Strict critical analysis"
echo "  /review-shepherd    - Constructive feedback"
echo "  /survey-literature  - Literature survey"
echo "  /thesis-review      - Thesis comprehensive review"
echo ""
echo "Usage example:"
echo "  claude> /review path/to/thesis.tex"
echo ""
