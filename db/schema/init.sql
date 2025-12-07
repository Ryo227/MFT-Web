-- データベースの初期化スクリプト
-- PostgreSQL用データベーススキーマ

-- userテーブル
CREATE TABLE IF NOT EXISTS "user" (
    user_id SERIAL PRIMARY KEY,
    user_name VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL
);

-- folderテーブル
CREATE TABLE IF NOT EXISTS folder (
    folder_id SERIAL PRIMARY KEY,
    folder_name VARCHAR(255) NOT NULL
);

-- configテーブル
CREATE TABLE IF NOT EXISTS config (
    config_id SERIAL PRIMARY KEY,
    config_type VARCHAR(255) NOT NULL,
    config_value TEXT,
    user_id INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES "user" (user_id) ON DELETE CASCADE
);

-- noteテーブル
CREATE TABLE IF NOT EXISTS note (
    note_id SERIAL PRIMARY KEY,
    note_name VARCHAR(255) NOT NULL,
    note_text TEXT,
    user_id INTEGER NOT NULL,
    folder_id INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES "user" (user_id) ON DELETE CASCADE,
    FOREIGN KEY (folder_id) REFERENCES folder (folder_id) ON DELETE CASCADE
);

-- インデックスの作成（パフォーマンス向上のため）
CREATE INDEX IF NOT EXISTS idx_config_user_id ON config (user_id);

CREATE INDEX IF NOT EXISTS idx_note_user_id ON note (user_id);

CREATE INDEX IF NOT EXISTS idx_note_folder_id ON note (folder_id);