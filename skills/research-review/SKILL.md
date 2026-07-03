---
name: research-review
description: 研究文書（概要/梗概/アブストラクト・研究論文・卒業論文）を種別自動判別し、研究の骨子・グローバル一貫性・当てどころ・関連研究・説明不足・弱点・体裁の各面から一括レビューして教員向け統合1ファイルに集約するメタスキル。framing-check(骨子＋一貫性)・aim-check(当てどころ)・articulation-check(5W)・weakness-analyze(弱点)・lit-survey(関連研究)で検出し、shepherd で内容面を整形、format-check(概要は --fixed で紙面配分)で体裁を見る。--student で student-comment に渡し学生向け1枚も生成。論文・概要・卒論・中間発表予稿を「レビューして」「総合的に見て」と言われたときに使う。旧 abstract-review / paper-review / thesis-review / review を統合。
argument-hint: "<.tex/.docx/.pdf path or dir> [--type abstract|paper|thesis] [--student] [--feedback <md>] [--deadline tomorrow|week|none] [--out <path>]"
metadata:
  author: nel
  version: 1.0.0
---

# Research Review — 研究文書 総合レビュー（統合メタ・教員向け）

研究文書を種別（**概要 / 研究論文 / 卒論**）ごとに適切なレンズで一括レビューし、**教員向けの統合1ファイル**にまとめる。判定は既存の部品スキルに委譲し、このスキルは「種別を見分け・レンズを合成し・内容面を整形し・重複を潰し・提出前の一手にまとめる」オーケストレーションに徹する。読者は**教員**（率直・野心を上げてよい）。学生に渡す1枚は `--student`。

## When to Use

- 概要・梗概・アブストラクト・中間発表予稿（1〜2p）／研究論文（学会投稿）／卒業論文 を、中身も体裁も**まとめて**建設的に見てほしいとき
- 単発の部品（framing-check / aim-check / articulation-check / weakness-analyze / lit-survey / format-check / shepherd / review-tracker）を個別に叩くのは、狙いが1点のときだけ
- **コード/PRレビューには使わない**（それは `/code-review`・本家 `/review`）

## Input

$ARGUMENTS

- ファイルパス: `.tex` / `.docx` / `.pdf` / `.md`、またはディレクトリ
- `--type abstract|paper|thesis`: 種別を明示（無指定なら自動判定＝下記 PHASE 0）
- `--student`: 統合レビュー完成後、その `.md` を `student-comment` に渡し学生向け1枚も生成
- `--feedback <md>`: 既存フィードバック（複数可）。既出指摘の重複を避ける
- `--deadline tomorrow|week|none`: 締切による比重調整（tomorrow=体裁を手厚く／none=内容を手厚く）
- `--out <path>`: 出力先（無指定なら入力と同じdir）

## PHASE 0. 種別の自動判別

`--type` があればそれに従う。無ければファイル冒頭と分量から判定する。

- **abstract（概要・固定尺）**: 1〜2ページ相当（`.pdf`はページ数、`.tex`は概要系 `\documentclass`／二段組み1ページ相当／本文が短い）。中間発表予稿・卒論梗概・学会概要。
- **thesis（卒論）**: 「卒業論文/修士論文/総合研究論文」等の語、`\documentclass` に thesis/sotsuron 等、指導教員・学籍番号・章立て（はじめに/関連研究/提案/実験/結論）。
- **paper（研究論文）**: 上記以外の長尺（英語Abstract始まりの学会論文形式等）。

判定結果（種別・形式・対象パス）を最初に表示する。**取り違えやすい 2ページ論文 vs 概要**は、疑わしければ `--type` を促す。

## PHASE 1. 検出（レンズを合成／独立なので並列でよい）

**全種別で以下を走らせる**（Task ツールで並列実行してよい。各レンズは自分のディレクトリに中間出力を書く）:

1. **骨子・一貫性** `framing-check` → `framing_output.md`。研究の鎖 L1-L6＋旗と物差しのズレ（construct validity）。**第一軸**。
2. **当てどころ** `aim-check` → `aim_output.md`。狙いの深さ／框の付け替え（深い框がある時だけ提案＋さじ加減）。
3. **説明不足** `articulation-check`。5W。
4. **弱点** `weakness-analyze` → `analyze_output.md`。論理・根拠・設計の弱点。
5. **関連研究** `lit-survey` → `survey_output.md`。関連研究・引用ギャップ・必須文献。**全種別で実施**（下記モード差参照）。
6. **体裁** `format-check`（abstract は `--fixed` ＝紙面配分込み）。

`--feedback` 指定時は各レンズに渡し、既出指摘を重複させない。

### 種別ごとのモード差（変わるのはここだけ）

| | 尺の扱い | format-check | lit-survey の用途 | 出力の色 |
|---|---|---|---|---|
| **abstract** | 固定尺。長尺前提の指摘（大規模統計・証明・章立て・関連研究網羅）は「提出後に検討」へ**格下げ** | `--fixed`（紙面配分） | 全部は載らない前提で「**必須文献の絞り込み＋L2/L6の空白**」に寄せる（網羅リストは提出後へ） | 提出前の最優先3手＋教員ファースト |
| **paper** | 長尺。指摘はそのまま本編 | 通常 | 網羅サーベイ | 研究としての弱点を厚めに |
| **thesis** | 長尺。締切近ければ体裁を最優先 | 通常 | 網羅サーベイ | **緊急体裁は最優先手／内容は提出後**の2部感（`--deadline` で比重） |

## PHASE 2. 内容面を shepherd で整形

`shepherd` を内容検出（framing/aim/articulation/weakness/lit-survey）の結果に対して実行し、impact×effort で優先順位付けした前向きな改善提案へ。**骨子・一貫性・当てどころの切れ目を優先上位**に。体裁（format-check）は整形を通さない（事実確認が主）。

## PHASE 3. 重複排除と仕分け

検出と shepherd 整形は必ず重なる。同根の指摘は1件に畳み、由来を観点タグで残す。
- abstract: 尺で書けない要求は「提出後に検討」へ格下げ。
- thesis: 締切が近ければ体裁を最優先手へ、内容を提出後へ。
- 残す指摘は重大度（Critical/Major/Minor）。`--feedback` の既出は「前回指摘の未対応」として簡潔に。

## PHASE 4. 統合ファイル書き出し

`<元ファイル名>-research-review-<YYYY-MM-DD>.md`（日付は `date +%Y-%m-%d`）。冒頭に「提出前の最優先3手」（骨子・一貫性・当てどころから供給）。本編は内容面（骨子→一貫性→当てどころ→関連研究→説明不足→弱点）を先、体裁を後。トーンは教員の朱書き（最上級・煽り語を抑制）。

## PHASE 5.（--student 指定時）学生向け翻訳

完成した統合 `.md` を入力に `student-comment` を呼び、学生向け1枚（`<元ファイル名>-学生向けコメント-<日付>.md`）を生成する。教員向けの厳しさは前段に残し、学生版は前向き・抑えめ・self-contained・優先順に翻訳（規範は student-comment 側）。

## Output Format（教員向け統合ファイル）

```markdown
# 研究レビュー結果: [タイトル]
**チェック日**: [YYYY-MM-DD] / **対象**: [パス]（＋PDF/docx併用明記）
**種別**: abstract / paper / thesis / **推定分量**: … / **既存FB**: [あれば]

> **レイアウト所見（PDF併用時・abstract）**: [占有率・余白。余白があれば「削らず足せる」旨]

## 🎯 提出前の最優先3手
1. **[一手]** — 由来: [骨子/一貫性/当てどころ/関連研究/説明不足/弱点/体裁] / 重大度 / 直し方: …

## 【内容面】
### ① 骨子の鎖＋グローバル一貫性（framing-check → shepherd）★第一軸
### ② 当てどころ／框の付け替え（aim-check）
### ③ 関連研究（lit-survey）  ← abstract は必須文献の絞り込み、paper/thesis は網羅
### ④ 説明不足（articulation-check → shepherd）
### ⑤ 研究の弱点（weakness-analyze → shepherd）

## 【体裁面】
### ⑥ 体裁（format-check／abstract は --fixed で紙面配分）

## 統合サマリ / ## 📌 提出後に検討 / ## 総評
```

## Guidelines

- **委譲に徹する**（判定ロジックを写経しない）。**内容を先・体裁を後**。**内容面だけ shepherd**。**重複を潰す**。**最優先3手を先頭に**。
- **種別で変わるのはモードだけ**（レンズ構成・尺の扱い・出力の色）。レンズ自体は全種別で共通。
- **abstract は固定尺を全観点に効かせる**（長尺前提の指摘は提出後へ）。PDFがあれば余白を見て「削る／足す」を判断。
- **thesis は締切感度**（`--deadline tomorrow` で体裁を最優先、内容は要点のみ）。
- 出力は**教員向け**。学生に渡すなら `--student`（`student-comment` が抑制と翻訳を担当）。
