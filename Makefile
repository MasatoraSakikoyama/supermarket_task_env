.PHONY: help init update sync status pull clone clean up down build restart logs ps

# デフォルトターゲット
help:
	@echo "利用可能なコマンド:"
	@echo ""
	@echo "=== Git Submodule コマンド ==="
	@echo "  make gs-init        - サブモジュールを初期化"
	@echo "  make gs-update      - サブモジュールを最新に更新"
	@echo "  make gs-sync        - .gitmodulesの設定を同期"
	@echo "  make gs-status      - サブモジュールの状態を表示"
	@echo "  make gs-pull        - サブモジュールの変更をプル"
	@echo "  make gs-clone       - リポジトリとサブモジュールをクローン (新規)"
	@echo ""
	@echo "=== Docker Compose コマンド ==="
	@echo "  make dc-up          - コンテナを起動"
	@echo "  make dc-up-build    - コンテナを起動（ビルド付き）"
	@echo "  make dc-up-d        - コンテナをバックグラウンドで起動"
	@echo "  make dc-up-build-d  - コンテナをバックグラウンドで起動（ビルド付き）"
	@echo "  make dc-down        - コンテナを停止・削除"
	@echo "  make dc-build       - コンテナをビルド"
	@echo "  make dc-restart     - コンテナを再起動"
	@echo "  make dc-logs        - コンテナのログを表示"
	@echo "  make dc-ps          - コンテナの状態を表示"
	@echo "  make dc-clean       - ボリュームを含めてクリーンアップ"

# ========================================
# Git Submodule コマンド
# ========================================

# サブモジュールを初期化
gs-init:
	git submodule update --init --recursive

# サブモジュールを最新に更新
gs-update:
	git submodule update --remote --recursive

# .gitmodulesの設定を同期
gs-sync:
	git submodule sync --recursive

# サブモジュールの状態を表示
gs-status:
	git submodule status --recursive

# サブモジュールのmainブランチの変更をプル
gs-pull-main:
	git submodule foreach --recursive git pull origin main

# サブモジュールのdevelopブランチの変更をプル
gs-pull-develop:
	git submodule foreach --recursive git pull origin develop

# リポジトリとサブモジュールをクローン (情報表示)
gs-clone:
	@echo "新規クローンする場合は以下のコマンドを実行してください:"
	@echo "git clone --recursive https://github.com/MasatoraSakikoyama/supermarket_task_env.git"

# ========================================
# Docker Compose コマンド
# ========================================

# コンテナを起動
dc-up:
	docker compose up

# コンテナを起動 (ビルド付き)
dc-up-build:
	docker compose up --build

# コンテナをバックグラウンドで起動
dc-up-d:
	docker compose up -d

# コンテナをバックグラウンドで起動 (ビルド付き)
dc-up-build-d:
	docker compose up -d --build

# コンテナを停止・削除
dc-down:
	docker compose down

# コンテナを停止・削除 (ボリューム削除付き)
dc-down-v:
	docker compose down -v

# コンテナをビルド
dc-build:
	docker compose build

# コンテナを再起動
dc-restart:
	docker compose restart

# コンテナのログを表示
dc-logs:
	docker compose logs -f

# コンテナの状態を表示
dc-ps:
	docker compose ps

# ボリュームを含めてクリーンアップ
dc-clean:
	docker compose down -v --rmi local

# clientコンテナのシェルに入る
dc-shell-client:
	docker compose exec -it client sh

# serverコンテナのシェルに入る
dc-shell-server:
	docker compose exec -it server bash
