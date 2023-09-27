-- テーブル設計の練習をするためのデータベースを作成する
-- データベース名は「company」
-- 既に存在する場合は削除して作成する
DROP DATABASE IF EXISTS company;

CREATE DATABASE company;

-- データベースが何があるか確認する --
SHOW DATABASES;

-- companyデータベースを使用する --
USE company;

-- 社員テーブルを作成する。社員番号、妙、名がある --
CREATE TABLE IF NOT EXISTS employee (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    number INTEGER NOT NULL,
    last_name TEXT NOT NULL,
    first_name TEXT NOT NULL
);

-- 別のパターンとして社員番号というソロゲートキーを使用したemployeeを作成 --
-- サロゲートがあると社員番号が４けたで同じ番号でも往復してもエラーが出ない --
CREATE TABLE IF NOT EXISTS employee (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    number INTEGER NOT NULL UNIQUE,
    last_name TEXT NOT NULL,
    first_name TEXT NOT NULL
);

-- 外部キーを使用した例。社員テーブルと部門テーブルのデータと連携をする --
-- 部門テーブルを作成する。部門番号と部門名がある --
CREATE TABLE IF NOT EXISTS department (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    number INTEGER NOT NULL UNIQUE,
    name TEXT NOT NULL
);

-- 社員テーブルを作成する。社員番号、妙、名、部門番号がある --
CREATE TABLE IF NOT EXISTS employee (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    number INTEGER NOT NULL UNIQUE,
    last_name TEXT NOT NULL,
    first_name TEXT NOT NULL,
    department_id INTEGER NOT NULL,
    FOREIGN KEY (department_id) REFERENCES department (id)
);

-- 部門テーブルにデータを追加 --
INSERT INTO department (number, name) VALUES (1, '営業部');
INSERT INTO department (number, name) VALUES (2, '開発部');

-- 社員テーブルにデータを追加 --
INSERT INTO employee (number, last_name, first_name, department_id) VALUES (101, '田中', '太郎', 1);
INSERT INTO employee (number, last_name, first_name, department_id) VALUES (102, '山田', '花子', 2);
