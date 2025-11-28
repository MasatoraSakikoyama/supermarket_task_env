.PHONY: help init update sync status pull clone clean up down build restart logs ps

# デフォルトターゲット
help:
	@echo "利用可能なコマンド:"
	@echo ""
	@echo "=== Git Submodule コマンド ==="
	@echo "  make init     - サブモジュールを初期化"
	@echo "  make update   - サブモジュールを最新に更新"
	@echo "  make sync     - .gitmodulesの設定を同期"
	@echo "  make status   - サブモジュールの状態を表示"
	@echo "  make pull     - サブモジュールの変更をプル"
	@echo "  make clone    - リポジトリとサブモジュールをクローン (新規)"
	@echo ""
	@echo "=== Docker Compose コマンド ==="
	@echo "  make up       - コンテナを起動"
	@echo "  make down     - コンテナを停止・削除"
	@echo "  make build    - コンテナをビルド"
	@echo "  make restart  - コンテナを再起動"
	@echo "  make logs     - コンテナのログを表示"
	@echo "  make ps       - コンテナの状態を表示"
	@echo ""
	@echo "=== その他 ==="
	@echo "  make clean    - ボリュームを含めてクリーンアップ"

# ========================================
# Git Submodule コマンド
# ========================================

# サブモジュールを初期化
init:
	git submodule update --init --recursive

# サブモジュールを最新に更新
update:
	git submodule update --remote --recursive

# .gitmodulesの設定を同期
sync:
	git submodule sync --recursive

# サブモジュールの状態を表示
status:
	git submodule status --recursive

# サブモジュールの変更をプル
pull:
	git submodule foreach --recursive git pull origin main

# リポジトリとサブモジュールをクローン (情報表示)
clone:
	@echo "新規クローンする場合は以下のコマンドを実行してください:"
	@echo "git clone --recursive https://github.com/MasatoraSakikoyama/supermarket_task_env.git"

# ========================================
# Docker Compose コマンド
# ========================================

# コンテナを起動
up:
	docker compose up -d

# コンテナを起動 (ビルド付き)
up-build:
	docker compose up -d --build

# コンテナを停止・削除
down:
	docker compose down

# コンテナをビルド
build:
	docker compose build

# コンテナを再起動
restart:
	docker compose restart

# コンテナのログを表示
logs:
	docker compose logs -f

# コンテナの状態を表示
ps:
	docker compose ps

# ========================================
# その他
# ========================================

# ボリュームを含めてクリーンアップ
clean:
	docker compose down -v --rmi local
