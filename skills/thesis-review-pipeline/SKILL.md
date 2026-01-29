---
name: thesis-review-pipeline
description: 卒業論文の包括レビューパイプライン。「レビューして」の一言でtex/docx問わず体裁チェック・内容レビュー・指摘統合を一括実行。卒論レビュー依頼時に使用。
argument-hint: "<file path> [--deadline tomorrow|week|none] [--feedback <既存feedback>] [--quick] [--keep-intermediate]"
---

# Thesis Review Pipeline (Meta-Skill)

You are orchestrating a comprehensive thesis review using three specialized skills with **parallel execution** for efficiency.

## When to Use

```
使い分けガイド:
  卒論の体裁だけチェック       → /thesis-format-check
  卒論を包括レビュー           → /thesis-review
  卒論を一括パイプラインで     → /thesis-review-pipeline（これ）
  研究論文を深くレビュー       → /review-paper
  複数レビューを統合・追跡     → /review-tracker
```

## Input

$ARGUMENTS

Required: ファイルパス（`.tex` または `.docx`）

Options:
- `--deadline tomorrow`: 明日締切 → 体裁優先（thesis-review に `--deadline tomorrow` を渡す）
- `--deadline week`: 1週間猶予 → バランス（デフォルト）
- `--deadline none`: 締切なし → 内容優先
- `--feedback <パス>`: 既存フィードバックファイル（thesis-review と review-tracker に渡す）
- `--quick`: thesis-format-check のみ実行（内容レビューをスキップ）
- `--keep-intermediate`: 中間ファイル（format_output.md, review_output.md）を削除せず残す

## Pipeline Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                  PHASE 0: ファイル形式判定                    │
│                  .tex / .docx を自動判別                      │
└──────────────────────────┬──────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────────┐
│                    PHASE 1 (PARALLEL)                        │
│  ┌──────────────────────┐  ┌───────────────────────────┐    │
│  │ /thesis-format-check │  │    /thesis-review         │    │
│  │ - 未記入・placeholder │  │  - 体裁面（Part 1）       │    │
│  │ - 表記ゆれ           │  │  - 内容面（Part 2）       │    │
│  │ - 参考文献体裁       │  │  - 既存FB重複排除         │    │
│  │ - label/ref整合性    │  │  - deadline考慮           │    │
│  │ - 図表整合性         │  │                           │    │
│  └──────────┬───────────┘  └──────────┬────────────────┘    │
│             │                         │                      │
│             └───────────┬─────────────┘                      │
│                         ▼                                    │
└─────────────────────────────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────────┐
│                    PHASE 2 (SEQUENTIAL)                      │
│           ┌───────────────────────────────┐                  │
│           │      /review-tracker          │                  │
│           │  - Phase 1 の2つを統合        │                  │
│           │  - 重複排除                   │                  │
│           │  - 優先度順チェックリスト     │                  │
│           │  - 対応状況判定               │                  │
│           └───────────────────────────────┘                  │
└─────────────────────────────────────────────────────────────┘
                          │
                          ▼
                  review_tracking.md（最終成果物）
```

## Execution Instructions

### Phase 0: ファイル形式判定

1. 引数からファイルパスを取得
2. 拡張子を確認（`.tex` / `.docx`）
3. ファイルの存在を確認
4. ファイルのディレクトリを `PAPER_DIR` として記憶（中間ファイルの保存先）

### Phase 1: Parallel Analysis (TRUE PARALLEL EXECUTION)

**CRITICAL**: You MUST execute thesis-format-check and thesis-review using **two Task tool calls in a SINGLE message**. This enables true parallel execution.

#### How to Achieve True Parallel Execution

Send ONE message containing TWO Task tool invocations:

1. First Task tool call:
   - description: "Format check thesis"
   - prompt: "Run /thesis-format-check on [FILE_PATH]. Save the full output to [PAPER_DIR]/format_output.md"
   - subagent_type: "general-purpose"

2. Second Task tool call (in the SAME message):
   - description: "Review thesis content"
   - prompt: "Run /thesis-review on [FILE_PATH] --deadline [DEADLINE_VALUE]. [If --feedback: --feedback FEEDBACK_PATH]. Save the full output to [PAPER_DIR]/review_output.md"
   - subagent_type: "general-purpose"

**DO NOT** call them sequentially in separate messages - that defeats the purpose of parallel execution.

#### Intermediate Output Files

Phase 1 produces two intermediate files in the paper's directory:
- `format_output.md` - 体裁チェック結果（from thesis-format-check）
- `review_output.md` - 包括レビュー結果（from thesis-review）

#### Standard Mode (no --quick flag):
Run both skills simultaneously as described above.

#### Quick Mode (--quick flag):
Skip thesis-review, run only thesis-format-check in Phase 1. Then skip Phase 2 and output `format_output.md` as the final result.

### Phase 2: Integration (Sequential)

After Phase 1 completes (both Task tools return), execute review-tracker:

3. **review-tracker** (sequential, depends on Phase 1):
   - Read `format_output.md` and `review_output.md` from paper directory
   - If `--feedback` was specified, include it as an additional input
   - Command: `/review-tracker [PAPER_DIR]/format_output.md [PAPER_DIR]/review_output.md --source [FILE_PATH]`
   - Output: `review_tracking.md` in the paper directory
   - After successful generation, delete `format_output.md` and `review_output.md` (unless `--keep-intermediate`)

## Output

The final deliverable is `review_tracking.md` in the paper's directory, containing:
- All findings from both thesis-format-check and thesis-review, unified
- Duplicates removed (体裁指摘が両方に出る場合は統合)
- Priority-sorted checklist
- Status tracking against the source document

After completion, display a summary to the user:

```
## Thesis Review Pipeline 完了

**対象**: [ファイルパス]
**モード**: [Full / Quick] | Deadline: [tomorrow/week/none]

### 実行結果
- Phase 1: thesis-format-check + thesis-review (並列実行)
- Phase 2: review-tracker (統合)

### 成果物
- `review_tracking.md` — 統合チェックリスト（優先度順）

### サマリ
- 総指摘数: N件（重複排除後）
- 致命的: n件 / 高: n件 / 中: n件 / 低: n件
```

## Guidelines

- **Parallel Execution**: Always run thesis-format-check and thesis-review using TWO Task tool calls in ONE message (unless --quick)
- **Intermediate Files**: Phase 1 outputs to `format_output.md` and `review_output.md`
- **Final Output**: Phase 2 merges intermediate files into `review_tracking.md`
- **Cleanup**: Intermediate files are deleted after merge (use `--keep-intermediate` to retain)
- 内部用語（殿、足軽等）を出力に含めない
- review-paper のアーキテクチャと一貫した設計を維持
- 各サブスキル（thesis-format-check, thesis-review, review-tracker）はスタンドアロンでも引き続き使用可能

## Special Instructions

If the file is `.docx`:
- thesis-format-check は LaTeX 固有チェック（label/ref等）をスキップし、適用可能な項目のみチェック
- thesis-review は通常通り実行

If the thesis is incomplete (missing chapters):
- Note which sections are missing
- Review what exists
- Provide guidance for unwritten sections

## Efficiency Notes

By running Phase 1 in parallel:
- **Full review**: thesis-format-check と thesis-review が同時実行され、逐次実行と比較して大幅に効率化
- **Quick review**: thesis-format-check のみの単一フェーズ実行

This parallel architecture is possible because:
1. thesis-format-check focuses on **体裁・形式面**（format and structure）
2. thesis-review focuses on **体裁＋内容面**（format + content, comprehensive）
3. Neither depends on the other's output
4. review-tracker synthesizes both, requiring their completion first
