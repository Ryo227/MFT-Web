# ベースイメージ（軽量なPythonベース）
FROM python:3.12-slim-trixie

# 環境変数設定
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# 必要なパッケージのインストール
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    ca-certificates

# 作業ディレクトリ作成
WORKDIR /Firestar

# アプリケーションのコードをコピー
COPY src pyproject.toml ./

# uvのインストール
ADD https://astral.sh/uv/install.sh /uv-installer.sh
RUN sh /uv-installer.sh && rm /uv-installer.sh
ENV PATH="/root/.local/bin/:$PATH"
RUN uv sync --compile-bytecode

# ポートを公開（Webの場合は通常 8550）
EXPOSE 8550