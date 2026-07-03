# LaTeX コンパイル診断（LaTeX モードのみ）

静的解析では検出できない問題をコンパイルの warning/error から検出する。**静的解析（チェック項目1〜9）の後に実行する。**

## エンジン自動判定

メインの `.tex` ファイルのプリアンブルから LaTeX エンジンを自動判定する:

| プリアンブルの記述 | エンジン |
|---|---|
| `luatexja`, `luatex-ja`, `luatexja-fontspec` | `lualatex` |
| `xeCJK`, `fontspec`（luatexja なし） | `xelatex` |
| 上記いずれもなし | `pdflatex` |

判定できない場合やコンパイルに失敗した場合は、ユーザに確認する。

## コンパイル実行

1. メインの `.tex` ファイルが存在するディレクトリに `cd` する
2. 判定したエンジンで **2パス** コンパイルする（`\ref`, `\tableofcontents` 等の解決のため）
3. コンパイルは `-interaction=nonstopmode` で実行し、エラーでも最後まで走らせる
4. `-halt-on-error` は**使わない**（warning を収集するため最後まで走らせる）

```bash
# 例: lualatex の場合
cd "<.texファイルのディレクトリ>"
lualatex -interaction=nonstopmode "<メインファイル名>.tex"
lualatex -interaction=nonstopmode "<メインファイル名>.tex"
```

**注意**:
- 既に `.pdf` が存在する場合も上書きコンパイルして構わない（最新のwarningを取得するため）
- bibtex/biber が必要な場合（`.bib` ファイルが存在し `\bibliography` または `\addbibresource` がある場合）は、1パス目と2パス目の間に `bibtex` または `biber` を実行する
- コンパイルに失敗（exit code ≠ 0）した場合でも `.log` が生成されていれば warning 解析を続行する
- コンパイル環境が存在しない（エンジンが見つからない）場合は、「コンパイル診断: スキップ（エンジン未検出）」と報告し、静的解析の結果のみを返す

## .log ファイルの解析

コンパイル完了後、`.log` ファイルから warning/error を抽出し、以下の分類で報告する:

**致命的（コンパイルエラー）:**
- `! LaTeX Error:` — LaTeX エラー（パッケージ不在、コマンド未定義等）
- `! Missing` — 構文エラー（括弧閉じ忘れ等）
- `Fatal error` — 致命的エラー

**高:**
- `LaTeX Warning: Reference .* undefined` — 未定義の `\ref` 参照（PDF上で `??` 表示）
- `LaTeX Warning: Citation .* undefined` — 未定義の `\cite` 参照
- `LaTeX Warning: Label .* multiply defined` — `\label` の重複定義
- `Missing character:` — フォントに含まれない文字の使用
- `File .* not found` — 画像等のファイル不在（エラーにならずwarningになるケース）

**中:**
- `Overfull \\hbox` (badness ≥ 10000 または超過幅 > 10pt) — 行がマージンを大きくはみ出している
- `Overfull \\vbox` — ページがはみ出している
- `LaTeX Warning: Float too large` — 図表がページに収まらない

**低:**
- `Overfull \\hbox` (超過幅 ≤ 10pt) — 軽微なはみ出し
- `Underfull \\hbox` (badness ≥ 5000) — 行の間延び（極端な場合のみ）
- `Underfull \\vbox` — ページの間延び

**無視（報告しない）:**
- `Underfull \\hbox` (badness < 5000) — 通常は問題なし
- パッケージの情報メッセージ（`Package ... Info:`）
- `luatexja` の既知の無害な警告
- `LaTeX Font Warning: Font shape` — フォント代替の情報メッセージ（ビルド環境依存で著者が制御困難なため）

## 報告形式

コンパイル診断の結果は、静的解析の結果とは別セクションとして報告する:

```markdown
## コンパイル診断

**エンジン**: lualatex（自動判定）
**コンパイル結果**: 成功（warning N件） / 失敗（error N件, warning N件）

### 致命的
1. **LaTeX Error: File `missing.sty` not found** (l.12)
   - 原因: パッケージ `missing` が未インストール
   - 修正: `tlmgr install missing` または `\usepackage` を削除

### 高
1. **Reference `fig:xxx` undefined** (l.45)
   - 原因: `\label{fig:xxx}` が定義されていない
   - 修正: 該当の図に `\label{fig:xxx}` を追加

### 中
1. **Overfull \hbox (15.2pt too wide)** in paragraph at l.123
   - 原因: 単語が長すぎて行に収まらない
   - 修正: `\allowbreak` の挿入、または文言の調整

### 低
- Overfull \hbox: N件（軽微）
- Underfull \hbox: N件
```
