# supermarket_task_env

このリポジトリは、複数のサブリポジトリを管理し、docker-composeを使用してローカル開発環境を構築します。

## サブリポジトリ

- **client**: フロントエンドクライアント (https://github.com/MasatoraSakikoyama/supermarket_task_client)
- **server**: バックエンドサーバー (https://github.com/MasatoraSakikoyama/supermarket_task_server)

## 構成

- **nginx**: プロキシサーバー (localhost:80)
- **client**: Vite開発サーバー
- **localstack**: AWS LocalStack (Lambda, API Gateway, DynamoDB, S3)

## セットアップ

### 前提条件

- Docker
- Docker Compose
- Git

### リポジトリのクローン

```bash
git clone --recursive https://github.com/MasatoraSakikoyama/supermarket_task_env.git
cd supermarket_task_env
```

既にクローン済みの場合、サブモジュールを初期化:

```bash
git submodule update --init --recursive
```

### 起動

```bash
docker-compose up --build
```

### アクセス

- フロントエンド: http://localhost
- API: http://localhost/api/

### 停止

```bash
docker-compose down
```

## 開発

サブモジュールの更新:

```bash
git submodule update --remote
```