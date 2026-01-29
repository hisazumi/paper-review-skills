---
name: review
description: 論文の統合レビュー。卒論/研究論文を自動判別し、適切なレビューパイプラインを実行。「/review <file>」だけで全自動。thesis-review-pipeline と review-paper を統合した単一エントリポイント。
argument-hint: "<file path> [--type thesis|paper] [--deadline tomorrow|week|none] [--feedback <file>] [--quick] [--keep-intermediate]"
---

# Review - 統合論文レビュー (Meta-Skill)

You are orchestrating a comprehensive paper review that **automatically determines** whether the input is a thesis or research paper, then dispatches to the appropriate review pipeline with **parallel execution** for efficiency.

## Overview

```
使い分けガイド（統合後）:
  論文をレビュー（全自動）       → /review（これ）
  卒論の体裁だけチェック         → /thesis-format-check
  卒論を包括レビュー（単体）     → /thesis-review
  研究論文の分析のみ             → /review-analyze
  説明不足を検出                 → /check-articulation
  複数レビューを統合・追跡       → /review-tracker
```

## Input

$ARGUMENTS

Required: ファイルパス（`.tex`、`.docx`、`.pdf`、`.md`）

Options:
- `--type thesis|paper`: 自動判別をオーバーライドして論文種別を指定
- `--deadline tomorrow|week|none`: 締切による優先度調整（卒論パスのみ有効）
- `--feedback <パス>`: 既存フィードバックファイル（複数指定可）
- `--quick`: 簡易モード（卒論→format-checkのみ、研究論文→review-analyzeのみ）
- `--keep-intermediate`: 中間ファイルを削除せず残す

## Pipeline Architecture

```
┌─────────────────────────────────────────────────────────────┐
│               PHASE 0: 自動判別（Type Detection）            │
│                                                             │
│  1. ファイル形式判定: .tex / .docx / .pdf / .md             │
│  2. 論文種別判定: thesis（卒論） vs paper（研究論文）         │
│     --type 指定時はオーバーライド                            │
└──────────────┬──────────────────────┬───────────────────────┘
               │                      │
        ┌──────┘                      └──────┐
        ▼                                    ▼
┌────────────────────────┐    ┌────────────────────────────┐
│   THESIS PATH（卒論）   │    │  PAPER PATH（研究論文）     │
│                        │    │                            │
│  Phase 1 (PARALLEL)    │    │  Phase 1 (PARALLEL)        │
│  ┌──────────────────┐  │    │  ┌────────────────────┐    │
│  │/thesis-format-   │  │    │  │/survey-literature  │    │
│  │ check            │  │    │  │ - Related work     │    │
│  │ → format_output  │  │    │  │ → survey_output    │    │
│  │   .md            │  │    │  │   .md              │    │
│  └──────────────────┘  │    │  └────────────────────┘    │
│  ┌──────────────────┐  │    │  ┌────────────────────┐    │
│  │/thesis-review    │  │    │  │/review-analyze     │    │
│  │ → review_output  │  │    │  │ → analyze_output   │    │
│  │   .md            │  │    │  │   .md              │    │
│  └──────────────────┘  │    │  └────────────────────┘    │
│                        │    │                            │
│  Phase 2 (SEQUENTIAL)  │    │  Phase 2 (SEQUENTIAL)      │
│  ┌──────────────────┐  │    │  ┌────────────────────┐    │
│  │/review-tracker   │  │    │  │/review-shepherd    │    │
│  │ - 統合・重複排除 │  │    │  │ - Integrate        │    │
│  │ - 優先度チェック │  │    │  │ - Prioritize       │    │
│  │   リスト         │  │    │  │ - Feedback         │    │
│  └──────────────────┘  │    │  └────────────────────┘    │
│          │             │    │          │                 │
│          ▼             │    │          ▼                 │
│  review_tracking.md    │    │     REVIEW.md              │
└────────────────────────┘    └────────────────────────────┘
```

## Internal Sub-Skills

このメタスキルが内部で呼び出すスキル一覧:

| スキル | 用途 | パス |
|--------|------|------|
| `/thesis-format-check` | 卒論の体裁チェック | 卒論パス Phase 1 |
| `/thesis-review` | 卒論の包括レビュー | 卒論パス Phase 1 |
| `/review-tracker` | 指摘統合・追跡 | 卒論パス Phase 2 |
| `/survey-literature` | 関連研究調査 | 研究論文パス Phase 1 |
| `/review-analyze` | 論文の批判的分析 | 研究論文パス Phase 1 |
| `/review-shepherd` | 建設的フィードバック統合 | 研究論文パス Phase 2 |

## Execution Instructions

### Phase 0: 自動判別

1. **ファイル形式判定**: 拡張子を確認（`.tex` / `.docx` / `.pdf` / `.md`）
2. **ファイルの存在確認**: ファイルが存在しなければエラー
3. **`PAPER_DIR` を記憶**: ファイルのディレクトリ（中間ファイルの保存先）
4. **`--type` が指定されている場合**: 指定値を使用し、判別ロジックをスキップ
5. **論文種別の自動判別**:

   ファイルの冒頭部分を読み込み、以下の基準で判定する。

   **卒論（thesis）と判定する条件**（いずれか1つに該当）:
   - タイトルや本文冒頭に「卒業論文」「修士論文」「博士論文」「総合研究論文」「学位論文」「bachelor thesis」「master thesis」「doctoral thesis」等を含む
   - `.tex` の場合: `\documentclass` に `thesis`、`sotsuron`、`shuuron` 等を含む
   - 章構成が卒論パターン: 「はじめに」「関連研究」「提案」「実験/検証」「結論」のような構成
   - 指導教員・学籍番号・学科名等の記述がある

   **研究論文（paper）と判定する条件**:
   - 上記のいずれにも該当しない場合
   - Abstract が英語で始まる学会論文形式
   - ページ数が短い（概ね20ページ未満で章立てがない）

6. **判定結果を表示**:
   ```
   📋 判定結果: [thesis / paper]
   📂 対象: [ファイルパス]
   📄 形式: [.tex / .docx / .pdf / .md]
   ```

### Thesis Path（卒論パス）

#### Phase 1: Parallel Analysis

**CRITICAL**: You MUST execute thesis-format-check and thesis-review using **two Task tool calls in a SINGLE message**.

Send ONE message containing TWO Task tool invocations:

1. First Task tool call:
   - description: "Format check thesis"
   - prompt: "Run /thesis-format-check on [FILE_PATH]. Save the full output to [PAPER_DIR]/format_output.md"
   - subagent_type: "general-purpose"

2. Second Task tool call (in the SAME message):
   - description: "Review thesis content"
   - prompt: "Run /thesis-review on [FILE_PATH] --deadline [DEADLINE_VALUE]. [If --feedback: --feedback FEEDBACK_PATH]. Save the full output to [PAPER_DIR]/review_output.md"
   - subagent_type: "general-purpose"

**Quick Mode** (`--quick`): thesis-format-check のみ実行。Phase 2 をスキップし `format_output.md` を最終成果物とする。

#### Phase 2: Integration

After Phase 1 completes:

- Run `/review-tracker` with `format_output.md` and `review_output.md`
- If `--feedback` was specified, include it as additional input
- Output: `review_tracking.md` in PAPER_DIR
- Delete intermediate files (unless `--keep-intermediate`)

### Paper Path（研究論文パス）

#### Phase 1: Parallel Analysis

**CRITICAL**: You MUST execute survey-literature and review-analyze using **two Task tool calls in a SINGLE message**.

Send ONE message containing TWO Task tool invocations:

1. First Task tool call:
   - description: "Survey literature"
   - prompt: "Run /survey-literature on [FILE_PATH]. Save to [PAPER_DIR]/survey_output.md"
   - subagent_type: "general-purpose"

2. Second Task tool call (in the SAME message):
   - description: "Analyze paper"
   - prompt: "Run /review-analyze on [FILE_PATH]. Save to [PAPER_DIR]/analyze_output.md"
   - subagent_type: "general-purpose"

**Quick Mode** (`--quick`): review-analyze のみ実行。Phase 2 をスキップし `analyze_output.md` を最終成果物とする。

#### Phase 2: Synthesis

After Phase 1 completes:

- Run `/review-shepherd` with `survey_output.md` and `analyze_output.md`
- Integrate findings, transform to constructive feedback, prioritize improvements
- Output: `REVIEW.md` in PAPER_DIR
- Delete intermediate files (unless `--keep-intermediate`)

## Output

### Thesis Path の最終成果物

`review_tracking.md` — 統合チェックリスト（優先度順）

### Paper Path の最終成果物

`REVIEW.md` — 統合レビューレポート

### 完了時の表示

```
## Review 完了

**対象**: [ファイルパス]
**判定**: [thesis / paper] [--type で指定 / 自動判別]
**モード**: [Full / Quick] | Deadline: [tomorrow/week/none / N/A]

### 実行パイプライン
- Phase 0: 論文種別判定 → [thesis / paper]
- Phase 1: [サブスキル1] + [サブスキル2] (並列実行)
- Phase 2: [統合スキル]

### 成果物
- `[成果物ファイル名]` — [説明]

### サマリ
- 総指摘数: N件（重複排除後）
- [パスに応じた優先度別件数]
```

## Guidelines

- **Parallel Execution**: Phase 1 は必ず TWO Task tool calls in ONE message で並列実行
- **Intermediate Files**: Phase 1 で中間ファイルを生成、Phase 2 で統合
- **Cleanup**: 中間ファイルは統合後に削除（`--keep-intermediate` で保持）
- 内部用語（殿、足軽等）を出力に含めない
- 判定結果は必ずユーザーに表示し、誤判定の場合は `--type` での再実行を案内

## Special Instructions

### 不完全な論文の場合
- 欠落セクションを指摘
- 存在する部分をレビュー
- 未執筆セクションへのガイダンスを提供

### 非英語論文の場合
- 論文の言語でレビュー
- 必要に応じてキーワードを両言語で記載

### .docx ファイルの場合
- 卒論パス: thesis-format-check は LaTeX 固有チェックをスキップ
- テキスト抽出に基づくため図表の視覚的レイアウトは確認対象外

### .pdf ファイルの場合
- Read ツールで読み込み可能。テキスト抽出結果に基づくレビュー
- レイアウト・体裁の詳細チェックは制限がある旨を明記

## Efficiency Notes

Phase 1 の並列実行により:
- **Full review**: 逐次実行と比較して大幅に効率化
- **Quick review**: 単一スキルの実行のみ

並列実行が可能な理由:
- 卒論パス: thesis-format-check（体裁面）と thesis-review（体裁＋内容面）は互いに独立
- 研究論文パス: survey-literature（外部文脈）と review-analyze（内部品質）は互いに独立
- Phase 2 のみ Phase 1 の結果に依存
