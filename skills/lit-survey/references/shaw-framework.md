# Shaw のSE論文分類フレームワーク

Source: Mary Shaw, "Writing Good Software Engineering Research Papers" (ICSE 2003)
Revisited: Theisen et al., "Writing Good Software Engineering Research Papers: Revisited" (ICSE 2017)

## 概要

SE論文を3つの軸で分類し、論文の性質と研究の位置づけを明確にするフレームワーク。
関連研究のサーベイ時に、各論文がどのような貢献をしているかを整理するのに使用する。

---

## 軸1: Research Question Type（研究課題の種類）

| 種類 | 説明 | 典型的な研究課題 |
|------|------|----------------|
| Method / Procedure | より良い方法はあるか？ | 「Xを行うための新しい手法を提案する」 |
| Qualitative / Descriptive | 何が起きているか？ | 「開発者はXをどのように行っているか？」 |
| Empirical | 仮説は正しいか？ | 「XはYより効果的か？」 |
| Analytic | 形式的にどう特徴づけられるか？ | 「Xの計算量は？」 |
| Design / Evaluation | 提案した設計は機能するか？ | 「ツールXは問題Yを解決するか？」 |

## 軸2: Contribution Type（貢献の種類）

| 種類 | 説明 | 例 |
|------|------|-----|
| Procedure / Technique | 新しい手法・手順 | テスト戦略、開発プロセス |
| Qualitative Model | 構造的/記述的モデル | 分類体系、デザインパターン、フレームワーク |
| Empirical Model | データ駆動モデル | コスト推定モデル、欠陥予測モデル |
| Analytic Model | 形式モデル | 形式仕様、アルゴリズム計算量分析 |
| Tool / Notation | 実装されたツール・記法 | 静的解析ツール、DSL |
| Specific Solution | 特定問題への解法 | 特定システムのリファクタリング |
| Report | 経験・知見の報告 | ケーススタディ報告、実践知 |

## 軸3: Validation Approach（検証方法）

強い順に:

| 種類 | 強さ | 説明 |
|------|------|------|
| Analysis | ★★★★★ | 数学的証明、形式的分析 |
| Evaluation | ★★★★ | 体系的な実験・比較評価 |
| Experience | ★★★ | 実世界での使用経験の報告 |
| Example | ★★ | 具体例での動作デモ |
| Persuasion | ★ | 論理的議論のみ（実証なし） |
| None | - | 検証なし |

### 検証方法の妥当性ガイドライン

- **Method/Procedure の貢献**: 最低でも Evaluation（比較実験）が望ましい
- **Tool の貢献**: Example は最低限、Evaluation が望ましい
- **Qualitative Model**: Experience 以上が望ましい
- **Empirical Model**: Evaluation（統計的検証）が必須
- **Report**: Experience が基本（ただし外部一般化の議論が必要）

---

## 関連文献の分類表テンプレート

サーベイ結果を整理する際に以下の表形式を使用:

```markdown
| Paper | Year | RQ Type | Contribution | Validation | Relevance |
|-------|------|---------|-------------|------------|-----------|
| Author et al. | YYYY | Method | Tool | Evaluation | なぜ関連するか |
```

## 対象論文の自己分類テンプレート

論文ドラフトの分析時に:

```markdown
### 論文の分類（Shaw Framework）
- **Research Question Type**: [種類] — [根拠]
- **Contribution Type**: [種類] — [根拠]
- **Validation Approach**: [種類] (強さ: ★x) — [根拠]
- **検証の妥当性**: [妥当/不十分] — [理由]
```
