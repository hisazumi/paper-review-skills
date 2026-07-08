# Paper Review Skills

久住研で原稿を添削してもらうときの**進め方**（GitHub＋Issue でのやり取り）と、提出前に自分でかける**レビュー道具**（Claude Code スキル／任意LLM用プロンプト）をまとめたリポジトリです。研究概要・中間発表予稿・研究論文・卒業論文のいずれにも使えます。

This repo bundles the **review workflow** used in the Hisazumi lab (share via a GitHub repo, discuss in Issues) and the **self‑review tools** you run before submitting — as **Claude Code skills** or **copy‑paste prompts for any LLM** (ChatGPT / Gemini / …).

---

## 添削の進め方（久住研）

原稿の添削は **GitHub のリポジトリと Issue** で進めます。中間発表の予稿でも、卒業論文でも、学会論文でも、やり方は同じです。

なぜこの形かというと——**履歴が残る**（言った言わないが起きない）、**非同期で進む**（対面の時間を待たず互いの都合で書ける・返せる）、**優先順位がはっきりする**（「提出まで必ず直す」ものと「提出後でよい」ものを分けて渡します）。以下の流れを一度つかめば、あとは繰り返すだけです。

### 1. 最初に（一度だけ）

- 自分の **GitHub リポジトリ**に原稿（`.tex` と `.pdf`）を置く。
- **久住を collaborator に招待**する。招待がないと Issue でのやり取りができません。
- 日々のレビュー・質問・相談は、メールや Teams ではなく **その Issue** に集約します（やり取りの履歴が残るので）。

> **込み入ったことは、口頭でも遠慮なく。** 文字だと書きにくい、早めに相談したい、ということがあれば、**いつでも気軽に声をかけてください。ゼミを待つ必要はありません。** 都合がつく限り、対面でもオンラインでも相談に乗ります。相談した結果をどのように理解したかを、ミーティングの後に Issue に追加してもらえると良いと思います。久住はよく忘れてしまうのでどのような議論をしたのかを思い出すのに役立ちますし、コミュニケーションに齟齬があれば早めに気づくことができます。

> リポの構成やファイル名は自由です。ひとつだけ、**「久住側でも開いて読める・ビルドできる状態」で共有**してください。必要なスタイルファイルなどが欠けていると、こちらでも確認できず止まってしまいます。

### 2. 見てもらう前に：まず自分で読む、そして自分でレビューする

いちばん大事なのは、**自分の目で通し読みすること**です。LLM は補助であって、丸投げにはしないでください。

1. **LLM にかける前に**、自分で一度通して読む（声に出すと粗が見つかりやすい）。
2. LLM のレビューにかけて、指摘をもらう（かけ方は下の「まず何を使う？」を参照）。
3. **指摘を受け取った後にも、もう一度自分で読む**（LLM の指摘が的外れなこともあります。採否は自分で判断）。

自分で直せるものを先に直しておくと、久住との議論を本質的な中身に集中できます。

### 3. レビューを受け取る

久住が **Issue にレビューを書きます**。だいたい次の順で並びます。

1. **良い点**（土台の確認）
2. **提出まで（この順で）** ← 最優先。ここから手をつける
3. できれば（余裕があれば）
4. 提出後でよい
5. 体裁（誤字・参照など）
6. 補足（なぜそう直すかの理由）

読み方のコツ：

- **「提出まで」を上から順に**片づける。「提出後」は今はやらなくて大丈夫。
- 例文（例）…）が付くことがありますが、**そのまま写さず自分の言葉に**直してください。

### 4. 修正して Issue で返信する

- 原稿を直して **push** する。
- Issue に **「何を直したか」を項目で返信**する。

> 例）
> 1) 仮説を1文で言い切りました（考察の冒頭）
> 2) 関連研究との差分を一文追加しました
> 3) 参考文献の体裁を揃えました

「直しました」の一言よりも、上のように**箇条書きで対応を示す**と、確認が速く進みます。

- **納得いかない点・迷う点は、同じ Issue で積極的に質問しましょう。** 議論は歓迎です。
- **別のテーマは、新しい Issue を立ててOK。**

### 5. 完了の合図

- 久住が承認して **Issue を close** ＝ その内容は確定、という合図です。
- Issue が **Open のまま** ＝ まだあなたの手番か、議論の途中、という意味です。迷ったら「次は自分が動く番ですか？」と聞いて構いません。

### 困ったとき

**どう進めればいいか分からない**：

- まったく言葉にできそうにない：とりあえずミーティングを要求してください。
- ちょっとは言葉にできそう：相談内容を簡単にでいいので Issue に書いてください。テキストで返信できそうな時はそうしますし、ミーティングしたほうが良いと判断したらそのように依頼します。

---

# レビュー道具 / Self‑review tools

提出前に自分でかけるレビュー道具です。上の「見てもらう前に」で使います。

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
