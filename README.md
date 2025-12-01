# supermarket_task_env

このリポジトリは、複数のサブリポジトリを管理し、docker-composeを使用してローカル開発環境を構築します。

## サブリポジトリ

- **client**: フロントエンドクライアント (https://github.com/MasatoraSakikoyama/supermarket_task_client)
- **server**: バックエンドサーバー (https://github.com/MasatoraSakikoyama/supermarket_task_server)

## 構成

- **nginx**: プロキシサーバー (localhost:80)
- **client**: Vite開発サーバー
- **redis**: セッション管理・キャッシュ用Redis

## セットアップ

### 前提条件

- Docker
- Docker Compose
- Git
- Make

### リポジトリのクローン

```bash
git clone --recursive https://github.com/MasatoraSakikoyama/supermarket_task_env.git
cd supermarket_task_env
```

既にクローン済みの場合、サブモジュールを初期化:

```bash
make init
```

### 起動

```bash
make up-build
```

### アクセス

- フロントエンド: http://localhost
- API: http://localhost/api/

### 停止

```bash
make down
```

## Makeコマンド一覧

利用可能なコマンドを確認:

```bash
make help
```

### Git Submodule コマンド

| コマンド | 説明 |
|---------|------|
| `make init` | サブモジュールを初期化 |
| `make update` | サブモジュールを最新に更新 |
| `make sync` | .gitmodulesの設定を同期 |
| `make status` | サブモジュールの状態を表示 |
| `make pull` | サブモジュールの変更をプル |

### Docker Compose コマンド

| コマンド | 説明 |
|---------|------|
| `make up` | コンテナを起動 |
| `make up-build` | コンテナをビルドして起動 |
| `make down` | コンテナを停止・削除 |
| `make build` | コンテナをビルド |
| `make restart` | コンテナを再起動 |
| `make logs` | コンテナのログを表示 |
| `make ps` | コンテナの状態を表示 |
| `make clean` | ボリュームを含めてクリーンアップ |