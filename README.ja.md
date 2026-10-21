<h1 align="center">Agent HUD</h1>

<p align="center">
  <strong>エージェントの状態を、ひと目で。</strong><br>
  Claude Code、Codex ほか計 18 のエージェントの使用量、トークン、セッションを、Mac のノッチや画面の端に表示します。
</p>

<p align="center">
  <a href="https://agenthud.app/mac"><img src="docs/buttons/mac.svg" alt="Mac 版 Agent HUD をダウンロード" width="180" height="36"></a>
  <a href="https://apps.apple.com/app/id6812113619"><img src="docs/buttons/app-store.svg" alt="App Store: iPhone と Apple Watch" width="138" height="36"></a>
  <a href="#ソースからビルド"><img src="docs/buttons/source.svg" alt="ソースから Agent HUD をビルド" width="181" height="36"></a>
</p>

<p align="center">
  <a href="#ソースからビルド"><img src="docs/badges/macos.svg" alt="macOS 14+" height="22"></a>
  <a href="Package.swift"><img src="docs/badges/swift.svg" alt="Swift 6" height="22"></a>
  <a href="LICENSE"><img src="docs/badges/license.svg" alt="Apache-2.0 ライセンス" height="22"></a>
</p>

<p align="center">
  <a href="README.md">English</a> · <a href="README.zh-CN.md">简体中文</a> · <strong>日本語</strong> · <a href="https://agenthud.app">公式サイト</a> · <a href="#対応エージェント">対応エージェント</a> · <a href="#ドキュメント">ドキュメント</a>
</p>

<p align="center">
  <img src="docs/videos/agent-hud-loop.webp" alt="MacBook のノッチで動く Agent HUD のツアー。グローが赤・黄・緑のクォータ区間で呼吸する。ホバーするとパネルが開き、Claude と Codex のクォータ、DeepSeek の残高、直近 24 時間のトークンとセッションが並ぶ。クリックすると Claude のクォータが消費ペース表示に変わる。Claude がテスト実行を求めてきて「今回のみ許可」で応答すると、返信は「新着の返信」リマインダーとして届き、カードの「セッションに戻る」で戻れる" width="800">
</p>

Agent HUD は、ほかのアプリで作業している間もコーディングエージェントの状態を見えるようにします。

- **クォータはあとどれくらい？** クォータの使用に合わせてグローが緑・黄・赤に変わります。ホバーで数字を確認できます。
- **どのエージェントが待っている？** 承認、質問、返信をひとつの場所にまとめ、クリックでセッションに戻れます。
- **トークンはどこへ？** 時間、エージェント、モデル、セッション、ターン別に統計を表示し、API 価格で費用を換算します。
- **Mac から離れているときは？** 同じ数字を iPhone と Apple Watch でも確認できます。

## ひと目で、ホバーで

<p align="center">
  <img src="docs/videos/simple-mode-tour.webp" alt="画面の左端に表示したシンプルモードのツアー。5 つのエージェントロゴがクォータのリングに入り、続いてパーセントと残高を表示する。ロゴにホバーするとそのエージェントのクォータが 1 行で表示され、クリックすると Claude のカードが開いて上限、消費ペース、24 時間のトークン棒グラフが並ぶ。権限リクエストに「今回のみ許可」で応答し、「新着の返信」リマインダーから「セッションに戻る」を開く。最後に HUD を上端へドラッグして戻す" width="800"><br>
  <sub>画面の左端に表示した<a href="#ボットモード設定">シンプルモード</a> · エージェントを分ける オン · サンプルデータ</sub>
</p>

**ひと目で。** グローは 5 時間枠や週間上限などのクォータごとに 1 色で表示します。使用率 70% 未満が緑、70% から黄、90% から赤です。シンプルモードでは各ロゴのリングが同じ役割を果たします。エージェントの実行中はグローの動きが速くなります。

**ホバーで。** パネルが開き、次の数字を表示します。

- **クォータ**: 各枠の使用率とリセットまでのカウントダウン、または消費ペース。
- **残高**: アカウント残高とプリペイド残高（対応エージェントのみ）。
- **トークン**: 直近 24 時間を 15 分刻みの棒グラフで表示。
- **セッション**: 最大 5 件。自分の対応待ちが先頭です。

**クォータが尽きる前の警告。** 使用率 90% で、またはリセットまで持たないと予測された時点で早めに通知します。

## ノッチでも、どのディスプレイでも

- **ノッチのある MacBook**: Agent HUD はノッチに表示されます。
- **ノッチのないディスプレイ**: そのディスプレイ専用の HUD が表示され、エージェントロゴの列を任意の画面端へドラッグできます。
- **各ディスプレイ**はそれぞれの[モード](#ボットモード設定)、位置、サイズ、グローを保持します。
- **リクエストとリマインダー**は、ポインタがあるディスプレイにだけ表示されます。

## 承認、質問、返信をひとつの場所に

エージェントがあなたを必要とすると、そのリクエストが HUD 上で待機します。対象のコマンド、ファイル、編集差分、ツール入力も表示されます。ウィンドウを切り替えずにその場で回答できます。

<p align="center">
  <img src="docs/screenshots/approvals.webp" alt="ノッチに 4 件の権限リクエストが待機している。先頭が開いており、Avatar.tsx の編集差分、「常に許可」で追加される Edit(src/**) の行、拒否・常に許可・今回のみ許可のボタンが並ぶ" width="720">
</p>

- **承認**: **拒否**、**今回のみ許可**、エージェントがルールを提示する場合は **常に許可**。
- **質問**: 選択肢を選ぶか、自分で回答を入力します。
- **返信**: ターンが終わると **新着の返信** リマインダーが表示されます。
- **ワンクリックで戻る**: セッションのタイトルまたは **セッションに戻る** で、そのスレッド、タブ、iTerm2 ペインへ移動します。

**Agent HUD が代わりに回答することはありません。** 10 分間放置したリクエストは、エージェント自身のプロンプトに戻ります。[対応状況はこちら](#対応エージェント)。

## トークンの行き先

統計ウィンドウは、Mac 上に 30 日分のトークン履歴を保持します。

<p align="center">
  <a href="docs/screenshots/usage-statistics.webp"><img src="docs/screenshots/usage-statistics.webp" alt="統計ウィンドウのトークンページ。積み上げトークングラフと合計・API 価格換算の費用、エージェントごとのカード（種類別トークンと費用）、今日・7 日・30 日の費用とキャッシュヒット率を含む最近の使用量、アクティビティヒートマップ" width="468"></a> <a href="docs/screenshots/mac-session.webp"><img src="docs/screenshots/mac-session.webp" alt="Claude Code セッションのページ。52M トークン（うちサブエージェント 6.0M）、API 価格換算で約 $24.72、26 ターン・217 呼び出し、コンテキスト 66%、キャッシュヒット 99%、サブエージェント部分を淡色にしたターン別トークングラフ、ターン 22 を呼び出しごとに展開した表示" width="330"></a><br>
  <sub>統計ウィンドウのトークンページとセッションページ · サンプルデータ</sub>
</p>

- **時間別**: 直近 5 時間、24 時間、7 日間、30 日間を、15 分刻みまでの棒グラフで表示。
- **エージェント・モデル別**: エージェントごとのカードと、モデルやトークン種別で絞り込めるグラフ。
- **セッション・ターン・呼び出し別**: ターンごとのトークン、コンテキストウィンドウの使用率、ターン内のすべてのモデル呼び出し。
- **サブエージェントとキャッシュ**: サブエージェントのトークンは親セッションに含め、期間・セッション・モデル別のキャッシュヒット率を表示。
- **費用の意味**: 公開されている API 価格があるモデルはその価格で換算し、≈ を付けます。サブスクリプションでは実際の請求額ではなく推定値です。

## iPhone でも

iPhone と Apple Watch 版の Agent HUD は、Mac が集めたクォータ、残高、トークン統計、セッションを、アプリ本体・ウィジェット・Watch に表示します。アプリは無料です。

<p align="center">
  <a href="docs/screenshots/iphone-home.webp"><img src="docs/screenshots/iphone-home.webp" alt="iPhone 版 Agent HUD のホームタブ。Claude と Codex のクォータカードに各枠の使用率とリセット時刻、DeepSeek のアカウント残高を表示" width="220"></a> <a href="docs/screenshots/iphone-sessions.webp"><img src="docs/screenshots/iphone-sessions.webp" alt="iPhone 版 Agent HUD のセッションタブ。今日の種類別トークンと費用、ターン別の棒グラフとコンテキスト使用率を含むセッション一覧" width="220"></a><br>
  <sub>iPhone 版 Agent HUD · ホームとセッション · サンプルデータ</sub>
</p>

**同じネットワーク内なら、閲覧は無料です。** [公式 Mac アプリ](https://agenthud.app/mac)で 設定 → ローカルネットワーク → **このMacを共有** をオンにします。同じ Apple アカウントの iPhone は自動で接続し、それ以外の iPhone は QR コードでペアリングします。Mac が直接 iPhone に配信し、Agent HUD のサーバーは介しません。

## Agent HUD Remote

**唯一の有料機能**で、Mac から離れているときのためのものです。自分の iCloud 経由で同期し、次を追加します。

- **任意のネットワーク**: iPhone、ウィジェット、Apple Watch で Mac の数字を表示。
- **会話**: Claude Code、Codex、Grok CLI、Grok Bot、Antigravity セッションのプロンプトと返信を iPhone で読めます。
- **リモートセッション**（実験的。Mac の 設定 → 実験的 でオン）: iPhone からツール呼び出しを許可・拒否し、Claude Code と Codex のセッションにメッセージを送れます。[ガイド](https://agenthud.app/guides/remote-sessions)を参照。
- **アラートとライブアクティビティ**: iPhone と Apple Watch への通知、実行中セッションのロック画面と Dynamic Island 表示。

最後の 3 つは、同じネットワーク内でも Agent HUD Remote が必要です。1・2・3 台の Mac 向けの月額または年額サブスクリプションで、最初の 1 週間は無料です。iPhone と Apple Watch は台数に含まれません。iPhone アプリで価格を確認して購読し、Mac の 設定 → サブスクリプション → **このMacを有効にする** をオンにしてください。

## ボット、モード、設定

**ボット。** 各エージェントのロゴには、ロゴと同じ形と色の小さなボットがいます。目はポインタを追い、承認が必要になると跳ね、ターンが終わると笑います。[全エージェントのボットを見る](docs/videos/agent-bots.gif)。

**モード。** 各ディスプレイは 3 つのうち 1 つで動作します。ノッチがある場合はノッチ、それ以外はダイナミックが既定です。

| モード | 表示 |
| --- | --- |
| **ノッチ** | ノッチに表示し、その周囲にグローを描きます。 |
| **シンプル** | 画面端に浮かぶ小さなパネル。各エージェントのロゴを、最も使われているクォータのリングで囲み、横に使用率を表示します。 |
| **ダイナミック** | 画面端にエージェントロゴの列を並べ、背後にグローを描きます。エージェントの実行中はロゴがボットになります。 |

**設定。** 表示するアカウントとクォータ、各ディスプレイのモード・サイズ・グロー、パネルの内容を選べます。アプリの表示言語は英語・日本語・简体中文です。**⌘⌥H** でグローの表示を切り替えます。

## 対応エージェント

監視したいエージェントをインストールしてサインインするだけで、Agent HUD が自動的に見つけます。18 すべてがトークンとセッションを報告します。

| エージェント | クォータ | ライブステータス | 承認 | 質問 | 返信 | ワンクリックで戻る | ターンと呼び出し |
| --- | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| **Claude&nbsp;Code** | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| **Codex** | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| **DeepSeek&nbsp;Harness** | 残高 | ✓ |  | ✓ | ✓ |  | ✓ |
| **Antigravity** | ✓ |  | ✓ |  | ✓ | ✓ |  |
| **Cursor** | ✓ |  |  |  | ✓ |  |  |
| **Grok&nbsp;CLI** | ✓ | ✓ |  |  | ✓ | ✓ |  |
| **Grok&nbsp;Bot** | ✓ |  |  |  |  | ✓ |  |
| **GitHub&nbsp;Copilot&nbsp;CLI** | ✓ | ✓ |  |  | ✓ |  |  |
| **OpenCode** | ✓ |  |  |  | ✓ | ✓ |  |
| **Kimi** | ✓ | ✓ |  |  | ✓ |  |  |
| **Pi** | ✓ | ✓ |  |  | ✓ | ✓ |  |
| **OpenClaw** |  | ✓ |  |  | ✓ |  |  |
| **Hermes&nbsp;Agent** |  |  |  |  |  |  |  |
| **ZCode** |  |  | ✓ | ✓ |  |  |  |
| **CodeBuddy** |  |  | ✓ |  | ✓ |  |  |
| **WorkBuddy** |  |  | ✓ |  |  |  |  |
| **Qwen&nbsp;Code** |  |  | ✓ |  | ✓ |  |  |
| **Devin&nbsp;CLI** | ✓（キャッシュ） | ✓ | ✓ |  | ✓ |  |  |

Devin の日次・週次クォータはローカルの CLI キャッシュから取得します。最新の値にするには CLI で更新してください。

ほかに **GLM Coding Plan** のクォータと、**Qoder** 版の承認に対応しています。Codex の承認には Codex 側でフックの信頼が必要で、Copilot のクォータには設定での同意が必要です。詳細は[各エージェントの説明](docs/providers.md)にあります。

## データの扱い

- **Mac 上で読む**: エージェントがすでに保持している記録。使用履歴はローカルデータベースに保存されます。
- **各ベンダーから読む**: クォータ、残高、Cursor の使用量を、エージェントの既存サインインまたは設定済みキーで取得します。モデルへメッセージを送る読み取りはなく、認証情報は保存しません。
- **Mac 上に書き込む**: リクエストと返信を受け取るため、各エージェント自身の設定にフックを追加します。設定 → 一般 の **クライアントフック** でまとめて削除できます。
- **アップロード**: このソースからビルドした版は何も送信しません。公式アプリが iPhone と共有する内容（iCloud 経由、ライブアクティビティ用）は[プライバシーポリシー](https://agenthud.app/privacy)に記載されています。

[データアクセス](docs/data-access.md)も参照してください。

## ソースからビルド

**必要なもの:** macOS 14 以降と、Swift 6 ツールチェーンを含む Xcode または Xcode Command Line Tools。

```sh
git clone https://github.com/jazzenchen/agent-hud-open.git
cd agent-hud-open
make check
make test
make run
```

`build/Agent HUD Open.app` をビルドして開きます。ローカル利用向けのアドホック署名なので、開発者アカウント、署名 ID、プロビジョニングプロファイルは不要です。エージェントなしで試す場合は、アプリを終了してから `make demo` を実行すると、サンプルデータで開きます。

<details>
<summary><strong>開発と組み込み</strong></summary>

| コマンド | 用途 |
| --- | --- |
| `make check` / `make test` | ソース境界の検査 / ユニットテストの実行 |
| `make build` / `make run` | ローカル署名アプリのビルド / ビルドして開く |
| `make demo` / `make snapshot` | サンプルデータで開く / UI を `build/snapshots` に描画 |

Swift パッケージは `AgentHUDSupport`（記録と識別子）、`AgentHUDCore`（プロバイダー、モデル、ストレージ）、`AgentHUDDesktop`（ネイティブ HUD と統計）を公開します。`AgentHUDOpen` はスタンドアロンの実行ファイルです。ホストは `DesktopApplication` 経由で設定ページとサービスを提供できます。[ホスト統合](docs/architecture.md#host-integration)を参照してください。

CI はソース境界を検査し、ユニットテストを実行し、アプリをビルドして署名とリソースを検証します。

</details>

## ドキュメント

[HUD と承認](docs/hud.md) · [プロバイダー](docs/providers.md) · [使用量の意味](docs/usage-semantics.md) · [セッションのライフサイクル](docs/session-lifecycle.md) · [セッションの移動](docs/session-navigation.md) · [データアクセス](docs/data-access.md) · [アーキテクチャ](docs/architecture.md) · [パフォーマンス](docs/performance.md) · [コマンドライン](docs/command-line.md) · [アップデート](docs/updates.md) · [ブランドアセット](docs/brand-assets.md) · [変更履歴](CHANGELOG.md)

## ライセンス

[Apache-2.0](LICENSE)。プロバイダーの参照情報とアイコン素材は[第三者の通知](THIRD_PARTY_NOTICES.txt)と[アイコンライセンス](Sources/AgentHUDDesktop/Resources/LobeIcons-LICENSE.txt)に従います。

## Star History

<a href="https://www.star-history.com/?repos=jazzenchen%2Fagent-hud-open&type=date&legend=top-left">
 <picture>
   <source media="(prefers-color-scheme: dark)" srcset="https://api.star-history.com/chart?repos=jazzenchen/agent-hud-open&type=date&theme=dark&legend=top-left" />
   <source media="(prefers-color-scheme: light)" srcset="https://api.star-history.com/chart?repos=jazzenchen/agent-hud-open&type=date&theme=light&legend=top-left" />
   <img alt="Star History Chart" src="https://api.star-history.com/chart?repos=jazzenchen/agent-hud-open&type=date&legend=top-left" />
 </picture>
</a>
