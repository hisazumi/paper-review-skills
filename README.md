# Paper Review Skills for Claude Code

論文レビュー用のClaude Codeスキル集 / Claude Code skills for academic paper review

## Overview / 概要

A comprehensive set of Claude Code skills for reviewing academic papers and theses. Covers everything from format checking to deep content analysis, with support for both LaTeX (`.tex`) and Word (`.docx`) formats.

卒業論文から研究論文まで対応する、Claude Codeスキル集です。体裁チェックから内容の深い分析まで、LaTeX (`.tex`) と Word (`.docx`) の両形式をサポートします。

## Quick Start / クイックスタート

```bash
# Thesis: one-command full pipeline / 卒論を一括レビュー
/thesis-review-pipeline path/to/thesis.tex --deadline tomorrow

# Research paper: full review / 研究論文を深くレビュー
/review-paper path/to/paper.pdf

# Quick format check only / 体裁だけチェック
/thesis-format-check path/to/thesis.docx
```

## Skills Overview / スキル一覧

### Which skill should I use? / 使い分けガイド

| Scenario / 場面 | Skill | Description / 説明 |
|---|---|---|
| 卒論を一括パイプラインで | `/thesis-review-pipeline` | 体裁チェック・内容レビュー・指摘統合を一括実行 |
| 卒論の体裁だけチェック | `/thesis-format-check` | 未記入・表記ゆれ・参考文献体裁・相互参照等 |
| 卒論を包括レビュー | `/thesis-review` | 体裁面＋内容面の2部構成レビュー |
| 研究論文を深くレビュー | `/review-paper` | 文献調査・批判的分析・フィードバックの3段パイプライン |
| 複数レビューを統合・追跡 | `/review-tracker` | 重複排除・優先度順チェックリスト生成 |
| 説明不足を検出 | `/check-articulation` | 5W分析で「何が足りないか」を特定 |
| 改善案を提示 | `/improve-articulation` | コピペ可能な具体的改善テキストを提案 |

---

## Pipeline Skills (Meta-Skills) / パイプラインスキル

### 1. `/thesis-review-pipeline` — Thesis Review Pipeline / 卒論レビューパイプライン

One-command comprehensive thesis review. Runs format check and content review in parallel, then integrates all findings into a single prioritized checklist.

「レビューして」の一言で体裁チェック・内容レビュー・指摘統合を一括実行するメタスキル。

```
Phase 0: ファイル形式判定（.tex / .docx）
    ↓
Phase 1 (PARALLEL):
  ├── /thesis-format-check  →  format_output.md
  └── /thesis-review        →  review_output.md
    ↓
Phase 2 (SEQUENTIAL):
  └── /review-tracker       →  review_tracking.md（最終成果物）
```

```bash
/thesis-review-pipeline path/to/thesis.tex
/thesis-review-pipeline thesis.docx --deadline tomorrow   # Format-priority mode
/thesis-review-pipeline thesis.tex --feedback prev.md     # Avoid duplicate findings
/thesis-review-pipeline thesis.tex --quick                # Format check only
/thesis-review-pipeline thesis.tex --keep-intermediate    # Keep intermediate files
```

| Option | Description |
|--------|-------------|
| `--deadline tomorrow` | 体裁優先モード（明日締切） |
| `--deadline week` | バランスモード（デフォルト） |
| `--deadline none` | 内容優先モード |
| `--feedback <path>` | 既存フィードバックと重複排除 |
| `--quick` | thesis-format-check のみ実行 |
| `--keep-intermediate` | 中間ファイルを保持 |

### 2. `/review-paper` — Research Paper Review Pipeline / 研究論文レビューパイプライン

Complete paper review pipeline for research papers. Runs literature survey and critical analysis in parallel, then synthesizes into constructive feedback.

研究論文用の完全レビューパイプライン。文献調査と批判的分析を並列実行し、建設的フィードバックに統合。

```
Phase 1 (PARALLEL):
  ├── /survey-literature  →  survey_output.md
  └── /review-analyze     →  analyze_output.md
    ↓
Phase 2 (SEQUENTIAL):
  └── /review-shepherd    →  REVIEW.md（最終成果物）
```

```bash
/review-paper path/to/paper.pdf
/review-paper paper.tex --quick              # Skip literature survey
/review-paper paper.md --focus logic         # Focus on logical analysis
/review-paper paper.tex --focus feedback     # Focus on constructive feedback
```

---

## Thesis Skills / 卒論スキル

### 3. `/thesis-format-check` — Thesis Format Check / 卒論体裁チェック

Comprehensive format and style checking for theses. Supports both LaTeX and Word formats.

卒業論文の体裁・形式面を網羅的にチェック。LaTeX (.tex) と Word (.docx) の両形式に対応。

**Check items / チェック項目:**

| Category | Items |
|----------|-------|
| **Common (tex/docx)** | 句読点統一 (C1), タイトル冗長語・キャピタライゼーション (C2), 図表番号書式 (C3), 章節言及形式 (C4), 箇条書き多用 (C5), 引用形式 (C6), 謝辞用語 (C7), 英語論文チェック (C8) |
| **LaTeX-specific** | 未記入・プレースホルダ, 表記ゆれ, 参考文献体裁(enダッシュ等), label/ref整合性, 図表整合性, 定型セクション, 章の改ページ |
| **docx-specific** | 誤字脱字, 全角半角混在, 文体統一, 節番号連番, 相互参照整合性, レイアウト(両端揃え・字下げ), 数式消失検出 |

```bash
/thesis-format-check path/to/thesis.tex
/thesis-format-check thesis.docx
/thesis-format-check path/to/dir/                   # Check all tex/docx in directory
/thesis-format-check thesis.tex --terms terms.txt    # Custom terminology list
```

### 4. `/thesis-review` — Thesis Comprehensive Review / 卒論包括レビュー

Two-part structured review: urgent format issues (Part 1) + content improvements for post-submission (Part 2). Deduplicates against existing feedback.

緊急の体裁面と提出後検討の内容面を分けた2部構成レビュー。既存フィードバックとの重複を自動排除。

```bash
/thesis-review path/to/thesis.tex
/thesis-review thesis.docx --deadline tomorrow       # Format-heavy
/thesis-review thesis.tex --feedback feedback_v1.md  # Avoid repeating known issues
```

**Content review includes / 内容面の観点:**
- 論理構造の一貫性
- 提案手法の説明の十分さ・汎用性チェック
- セクション間の役割分離（提案と評価の混同検出）
- 関連研究の網羅性
- 評価の妥当性

---

## Research Paper Skills / 研究論文スキル

### 5. `/survey-literature` — Literature Survey / 文献調査

Survey related literature for a research topic or paper draft. Finds relevant papers, identifies citation gaps, and suggests key references.

研究トピックや論文ドラフトの関連文献を調査。関連論文の発見、引用漏れの特定、重要参考文献の提案を行う。

```bash
/survey-literature "program slicing for verification"
/survey-literature path/to/paper.tex
```

### 6. `/review-analyze` — Critical Analysis / 批判的分析

Analyze a paper draft objectively and strictly. Identifies logic gaps, missing proofs, structural issues, and research weaknesses.

論文ドラフトを客観的かつ厳格に分析。ロジックの欠陥、証明不足、構造的問題、研究上の弱点を特定。レビュアーモード。

```bash
/review-analyze path/to/paper.pdf
```

### 7. `/review-shepherd` — Constructive Feedback / 建設的フィードバック

Transform review analysis into constructive, actionable feedback. Mentor/shepherd mode — strict but supportive.

レビュー分析を建設的で実行可能なフィードバックに変換。メンター/シェパードモード。

```bash
/review-shepherd path/to/paper.tex
/review-shepherd paper.md --analysis analysis.md     # Use prior analysis
/review-shepherd paper.tex --survey survey.md        # Use prior survey
```

---

## General Document Skills / 汎用ドキュメントスキル

### 8. `/check-articulation` — Articulation Gap Detection / 表現不足の検出

Detect articulation gaps in documents using 5W analysis (What, Why, How, When, Limits). Identifies what's **missing** in explanation, not what's **wrong**.

5W分析を用いて文書の表現不足を検出。「何が間違っているか」ではなく「何が説明不足か」を特定。

```bash
/check-articulation path/to/document.md
/check-articulation paper.tex --section "Chapter 3"
/check-articulation doc.pdf --focus why
```

### 9. `/improve-articulation` — Improvement Suggestions / 改善提案

Provide concrete, copy-paste-ready improvement suggestions for articulation gaps. Works with check-articulation output or directly on documents.

文書の表現不足に対するコピペ可能な具体的改善テキストを提案。check-articulationの出力にも直接適用可能。

```bash
/improve-articulation path/to/document.md
/improve-articulation check-articulation-output.md
```

**Two-phase workflow / 2段階ワークフロー:**

```bash
# Phase 1: Identify gaps / ギャップを検出
/check-articulation paper.tex

# Phase 2: Get improvement suggestions / 改善提案を取得
/improve-articulation <check-articulation output>
```

### 10. `/review-tracker` — Review Integration & Tracking / レビュー統合・追跡

Integrate multiple review results into a single document. Deduplicates findings, assigns priority, and tracks resolution status against the source document.

複数回のフィードバック・複数パートのレビュー結果を統合。重複排除・優先度順チェックリスト・対応状況追跡を一括生成。卒論に限らずコードレビュー・設計レビューにも使用可能。

```bash
/review-tracker review1.md review2.md --source thesis.tex
/review-tracker feedback_v1.md feedback_v2.md --output tracking.md
```

---

## Pipeline Architecture / パイプライン構成図

### Thesis Review Pipeline

```
                        INPUT
                     .tex / .docx
                          │
                    ┌─────┴─────┐
                    │  Phase 0  │  ファイル形式判定
                    └─────┬─────┘
            ┌─────────────┴─────────────┐
            │                           │
   ┌────────┴─────────┐    ┌───────────┴──────────┐
   │ thesis-format-    │    │    thesis-review      │
   │ check             │    │                       │
   │ (体裁チェック)     │    │ (包括レビュー)        │
   └────────┬─────────┘    └───────────┬──────────┘
            │     Phase 1 (並列)       │
            └─────────────┬─────────────┘
                          │
                 ┌────────┴────────┐
                 │ review-tracker  │
                 │ (統合・追跡)     │
                 └────────┬────────┘
                    Phase 2 (順次)
                          │
                          ▼
              review_tracking.md
                 (最終成果物)
```

### Research Paper Review Pipeline

```
                        INPUT
                  .tex / .md / .pdf
                          │
            ┌─────────────┴─────────────┐
            │                           │
   ┌────────┴─────────┐    ┌───────────┴──────────┐
   │ survey-literature │    │   review-analyze     │
   │ (文献調査)        │    │   (批判的分析)        │
   └────────┬─────────┘    └───────────┬──────────┘
            │     Phase 1 (並列)       │
            └─────────────┬─────────────┘
                          │
                 ┌────────┴────────┐
                 │ review-shepherd │
                 │ (フィードバック)  │
                 └────────┬────────┘
                    Phase 2 (順次)
                          │
                          ▼
                    REVIEW.md
                   (最終成果物)
```

### Standalone Skills

All skills can also be used independently:

```
/thesis-format-check  ─────►  Format report
/thesis-review        ─────►  review_comments_main.md
/survey-literature    ─────►  survey_output.md
/review-analyze       ─────►  analyze_output.md
/review-shepherd      ─────►  REVIEW.md
/check-articulation   ─────►  Articulation gap report
/improve-articulation ─────►  Improvement suggestions
/review-tracker       ─────►  review_tracking.md
```

---

## Recent Changes / 最近の変更点

- **thesis-review-pipeline**: 卒論レビューパイプライン（メタスキル）を新規追加。一言で体裁チェック→内容レビュー→指摘統合を一括実行
- **review-tracker**: レビュー統合・追跡スキルを新規追加。複数レビューの重複排除・優先度ソート・対応状況判定
- **tex/docx 両対応**: thesis-format-check と thesis-review が Word (.docx) 形式に対応。python-docx によるスタイル情報付きテキスト抽出をサポート
- **共通チェック項目 C1〜C8**: 論文の書き方ガイドに基づくチェック項目を強化
  - C1: 句読点・記号の統一（全角カンマピリオド推奨）
  - C2: タイトル冗長語検出・英語キャピタライゼーション
  - C3: 図表タイトルの番号書式
  - C4: 「第N章」「第N.N節」の記述形式
  - C5: 箇条書きの多用検出
  - C6: 参考文献の引用形式（文中/句読点後の使い分け）
  - C7: 謝辞の「指導教官」→「指導教員」統一
  - C8: 英語論文における主語 "I" 回避・イタリック強調
- **内容面チェック強化**: 提案セクションと評価セクションの混同チェック、提案の汎用性チェック（特定技術依存の検出）

---

## Supported File Formats / 対応ファイル形式

| Format | Thesis Skills | Research Paper Skills | General Skills |
|--------|--------------|----------------------|----------------|
| LaTeX (`.tex`) | ✅ | ✅ | ✅ |
| Word (`.docx`) | ✅ | — | ✅ |
| Markdown (`.md`) | — | ✅ | ✅ |
| PDF (`.pdf`) | — | ✅ | ✅ |
| Plain text (`.txt`) | — | — | ✅ |

---

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

---

## License / ライセンス

MIT License - See [LICENSE](LICENSE) for details.

MITライセンス - 詳細は[LICENSE](LICENSE)を参照。

## Author / 著者

nel

## Contributing / 貢献

Issues and pull requests are welcome.

Issue や Pull Request を歓迎します。
