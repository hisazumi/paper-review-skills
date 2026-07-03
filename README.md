# Paper Review Skills

研究文書（研究概要・中間発表予稿・研究論文・卒業論文）をレビューするための道具集。
**Claude Code のスキル**としても、**任意のLLMに貼るプロンプト**としても使えます。

A toolkit for reviewing academic writing (abstracts, conference/interim drafts, papers, theses).
Use it as **Claude Code skills** — or as **copy‑paste prompts for any LLM** (ChatGPT / Gemini / …).

---

## まず何を使う？ / Start here

**入口は1つ、`/research-review` です。** 概要か論文か卒論かを自動で見分け、研究の骨子・一貫性・当てどころ・関連研究・説明不足・弱点・体裁を一気に見て、**提出前の最優先手つき**の教員向けレビューを返します。

`/research-review` is the single entry point. It auto‑detects abstract / paper / thesis and runs every review lens, then returns a teacher‑facing report with a prioritized "top‑3 before submission" list.

```bash
/research-review path/to/abstract.tex            # 自動判別（概要/論文/卒論）
/research-review paper.pdf --type paper           # 種別を明示
/research-review thesis.docx --deadline tomorrow  # 締切近い＝体裁優先
/research-review abstract.tex --student           # 教員版＋学生向け1枚も出す
```

### 教員 → 学生の2層 / Teacher → student, two layers
`/research-review` の出力は**教員向け**（率直・厳しめ）。学生本人に渡す1枚が要るときは：

- `/research-review abstract.tex --student` … 教員版に続けて学生向け1枚を生成、または
- `/student-comment teacher-review.md` … 教員向けレビューを、前向き・抑えめ・優先順の**学生向け1枚**に翻訳。

厳しさは教員版に残し、学生には翻訳して渡す設計です。

---

## スキル一覧 / Skills

### Main（よく使う）
| Skill | 用途 |
|---|---|
| `/research-review` | 総合レビュー（概要/論文/卒論を自動判別）。`--type` `--student` `--deadline` `--feedback` |
| `/student-comment` | 教員向けレビュー → 学生向け1枚に翻訳 |
| `/format-check` | 体裁チェック（LaTeX/Word/PDF）。概要は `--fixed` で**紙面配分**（参考文献が本文を圧迫していないか等）も診断 |
| `/review-tracker` | 複数回・複数パートのレビューを統合し、重複排除＋優先度順チェックリスト |

### Lenses（`/research-review` が内部で使う。単体でも可）
| Skill | 観点 |
|---|---|
| `/framing-check` | 研究の骨子の鎖 L1–L6 ＋ **グローバル一貫性**（掲げた構成概念=旗 と 評価指標=物差し のズレ） |
| `/aim-check` | 研究の**当てどころの深さ**・より深い框への付け替え提案 |
| `/articulation-check` | 説明の抜けを 5W（What/Why/How/When/Limits）で検出＋改善案 |
| `/weakness-analyze` | 論理の飛躍・根拠不足・研究設計の弱点を厳格に |
| `/lit-survey` | 関連研究・引用ギャップの検出 |
| `/shepherd` | 分析結果を「厳しいけど前向き」な優先度つき改善提案へ変換 |

---

## Claude Code で使う / Install as Claude Code skills

前提: [Claude Code](https://claude.ai/code)。

```bash
git clone https://github.com/hisazumi/paper-review-skills.git
cd paper-review-skills
./install.sh
```

`install.sh` は `skills/` を `~/.claude/skills/` にコピーします（既存があれば確認）。

---

## Claude Code なしで使う / Use without Claude Code (`prompts/`)

ChatGPT・Gemini・その他のLLMを使う人は、`prompts/` フォルダの**プロンプトを丸ごとコピーして貼るだけ**。セットアップ不要です。

1. `prompts/research-review.md` を丸ごとコピー
2. 使うLLMの新しいチャットに貼る
3. 末尾の「ここに文書を貼る」以下を、レビューしたい概要・論文・卒論の本文に置き換えて送信

学生向け1枚が要るときは、その出力を `prompts/student-comment.md` に通します。単一観点だけ見たいときは `prompts/framing-check.md` などの単体プロンプトを。詳しくは [`prompts/README.md`](prompts/README.md)。

---

## 対応形式 / Supported formats

| Format | research-review | format-check | review-tracker |
|--------|:---:|:---:|:---:|
| LaTeX (`.tex`) | Yes | Yes | Yes |
| Word (`.docx`) | Yes | Yes | Yes |
| PDF (`.pdf`)  | Yes | Yes（概要の紙面配分に有利） | Yes |
| Markdown (`.md`) | Yes | -- | Yes |

---

## 保守について / For maintainers

`skills/` と `prompts/` は**生成物**です。元は作者の `~/.claude/skills/` にあるスキル本文で、`build/build.py` が
`skills/`（複製）・`prompts/`（frontmatter除去＋references展開した汎用プロンプト、meta は各レンズを inline した統合版）・
`install.sh` の対象一覧を再生成します。**編集はスキル側で行い、再ビルドしてください**（`skills/`・`prompts/` を手で直さない）。

```bash
python3 build/build.py --claude-dir ~/.claude/skills
```

---

## License / Author

MIT License — see [LICENSE](LICENSE). Author: hisazumi.
