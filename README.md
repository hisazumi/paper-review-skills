# Paper Review Skills for Claude Code

論文レビュー用のClaude Codeスキル集 / Claude Code skills for academic paper review

## Overview / 概要

This repository contains a set of Claude Code skills designed to assist with academic paper review and writing improvement.

本リポジトリは、論文レビューと文章改善を支援するClaude Codeスキル集です。

## Skills / スキル一覧

### 1. `/review-paper` - Complete Review Pipeline / 完全レビューパイプライン

Complete paper review pipeline that runs survey-literature and review-analyze in parallel (Phase 1), then review-shepherd (Phase 2).

文献調査と分析を並列実行（Phase 1）し、その後フィードバック生成（Phase 2）を行う完全レビューパイプライン。

```bash
/review-paper path/to/paper.pdf
/review-paper paper.tex --quick           # Skip literature survey
/review-paper paper.md --focus logic      # Focus on logical analysis
```

### 2. `/survey-literature` - Literature Survey / 文献調査

Survey related literature for a research topic or paper draft. Finds relevant papers, identifies citation gaps, and suggests key references.

研究トピックや論文ドラフトの関連文献を調査。関連論文の発見、引用漏れの特定、重要参考文献の提案を行う。

```bash
/survey-literature "program slicing for verification"
/survey-literature path/to/paper.tex
```

### 3. `/review-analyze` - Critical Analysis / 批判的分析

Analyze a paper draft objectively and strictly. Identifies logic gaps, missing proofs, structural issues, and research weaknesses. Reviewer mode.

論文ドラフトを客観的かつ厳格に分析。ロジックの欠陥、証明不足、構造的問題、研究上の弱点を特定。レビュアーモード。

```bash
/review-analyze path/to/paper.pdf
```

### 4. `/review-shepherd` - Constructive Feedback / 建設的フィードバック

Transform review analysis into constructive feedback with actionable improvements. Mentor/shepherd mode - strict but supportive.

レビュー分析を建設的で実行可能なフィードバックに変換。メンター/シェパードモード - 厳格だが支援的。

```bash
/review-shepherd path/to/paper.tex
/review-shepherd paper.md --analysis analysis.md
```

### 5. `/check-articulation` - Articulation Gap Detection / 表現不足の検出

Detect articulation gaps in documents using 5W analysis (What, Why, How, When, Limits). Identifies what's missing in explanation, not what's wrong.

5W分析（What, Why, How, When, Limits）を用いて文書の表現不足を検出。「何が間違っているか」ではなく「何が説明不足か」を特定。

```bash
/check-articulation path/to/document.md
/check-articulation paper.tex --section "Chapter 3"
/check-articulation doc.pdf --focus why
```

### 6. `/improve-articulation` - Improvement Suggestions / 改善提案

Provide concrete improvement suggestions for articulation gaps in documents. Works with check-articulation output or directly on documents.

文書の表現不足に対する具体的な改善提案を提供。check-articulationの出力、または文書に直接適用可能。

```bash
/improve-articulation path/to/document.md
/improve-articulation check-articulation-output.md
```

## Installation / インストール

### Prerequisites / 前提条件

- [Claude Code](https://claude.ai/code) installed and configured
- Claude Codeがインストール・設定済みであること

### Steps / 手順

1. Clone this repository / リポジトリをクローン:

```bash
git clone https://github.com/nel/paper-review-skills.git
cd paper-review-skills
```

2. Run the installer / インストーラを実行:

```bash
./install.sh
```

3. The installer will:
   - Copy skills to `~/.claude/skills/`
   - Ask before overwriting existing skills

   インストーラは以下を行います:
   - スキルを `~/.claude/skills/` にコピー
   - 既存スキルがある場合は上書き確認

## Usage Examples / 使用例

### Full Paper Review / 完全な論文レビュー

```bash
# In Claude Code
claude> /review-paper ~/papers/my-draft.pdf
```

This will:
1. Survey related literature (parallel)
2. Analyze the paper critically (parallel)
3. Generate constructive feedback (sequential)

以下を実行します:
1. 関連文献の調査（並列）
2. 論文の批判的分析（並列）
3. 建設的フィードバックの生成（順次）

### Quick Review (Skip Literature Survey) / クイックレビュー

```bash
claude> /review-paper ~/papers/my-draft.pdf --quick
```

### Check Document Articulation / 文書の表現チェック

```bash
claude> /check-articulation ~/docs/proposal.md
claude> /improve-articulation ~/docs/proposal.md
```

### Two-Phase Articulation Improvement / 2段階表現改善

```bash
# Phase 1: Identify gaps
claude> /check-articulation paper.tex > gaps.md

# Phase 2: Get improvement suggestions
claude> /improve-articulation gaps.md
```

## Supported File Formats / 対応ファイル形式

- LaTeX (`.tex`)
- Markdown (`.md`)
- PDF (`.pdf`)
- Plain text (`.txt`)

## License / ライセンス

MIT License - See [LICENSE](LICENSE) for details.

MITライセンス - 詳細は[LICENSE](LICENSE)を参照。

## Author / 著者

nel

## Contributing / 貢献

Issues and pull requests are welcome.

Issue や Pull Request を歓迎します。
