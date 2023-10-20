テーブルを作成する際に`IF NOT EXISTS`を使用することは一般的なアプローチで、既にテーブルが存在する場合は新しいテーブルを作成しません。これにより、データベースが既存のテーブルを上書きしないようにできます。以下は、このアプローチを取り入れたクエリ例です。

```sql
--SNSデータベースを作成--
CREATE DATABASE IF NOT EXISTS sns_db;

-- ユーザーテーブルを作成
CREATE TABLE IF NOT EXISTS user (
    user_id INT PRIMARY KEY,
    username VARCHAR(255),
    profile_info TEXT
);

-- 投稿テーブルを作成
CREATE TABLE IF NOT EXISTS post (
    post_id INT PRIMARY KEY,
    user_id INT,
    post_text TEXT,
    post_date TIMESTAMP,
    like_count INT DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES user (user_id)
);

-- Likeテーブル（中間テーブル）を作成
-- Likeテーブル（中間テーブル）を作成（"like"を"post_like"に変更）
CREATE TABLE IF NOT EXISTS post_like (
    like_id INT PRIMARY KEY,
    user_id INT,
    post_id INT,
    FOREIGN KEY (user_id) REFERENCES user (user_id),
    FOREIGN KEY (post_id) REFERENCES post (post_id)
);
```

これでテーブルを作成し、すでに存在する場合は無視することができます。

ダミーのマスターデータを挿入するには、INSERT文を使用します。以下はダミーデータを挿入する例です。

```sql
-- ダミーユーザーデータを挿入
INSERT INTO user (user_id, username, profile_info)
VALUES
    (1, 'ユーザー1', 'ユーザー1のプロフィール情報'),
    (2, 'ユーザー2', 'ユーザー2のプロフィール情報');

-- ダミー投稿データを挿入
INSERT INTO post (post_id, user_id, post_text, post_date)
VALUES
    (1, 1, 'ユーザー1の投稿1', NOW()),
    (2, 1, 'ユーザー1の投稿2', NOW()),
    (3, 2, 'ユーザー2の投稿1', NOW());

-- ダミーLikeデータを挿入
INSERT INTO post_like (like_id, user_id, post_id)
VALUES
    (1, 1, 3),
    (2, 2, 1),
    (3, 1, 3);
```

これにより、ダミーデータが各テーブルに挿入されます。必要に応じてデータを変更し、実際のデータベースに合わせて調整してください。

テーブルのデータを取得
```sql
-- ユーザーテーブルのデータを取得
SELECT * FROM user;
-- 投稿テーブルのデータを取得--
SELECT * FROM post;
-- Likeテーブルのデータを取得--
SELECT * FROM post_like;
```

テーブルの検索結果
```
mysql> SELECT * FROM user;
+---------+---------------+------------------------------------------+
| user_id | username      | profile_info                             |
+---------+---------------+------------------------------------------+
|       1 | ユーザー1     | ユーザー1のプロフィール情報              |
|       2 | ユーザー2     | ユーザー2のプロフィール情報              |
+---------+---------------+------------------------------------------+
2 rows in set (0.01 sec)

mysql> -- 投稿テーブルのデータを取得--
Query OK, 0 rows affected (0.00 sec)

mysql> SELECT * FROM post;
+---------+---------+-------------------------+---------------------+------------+
| post_id | user_id | post_text               | post_date           | like_count |
+---------+---------+-------------------------+---------------------+------------+
|       1 |       1 | ユーザー1の投稿1        | 2023-10-19 06:51:58 |          0 |
|       2 |       1 | ユーザー1の投稿2        | 2023-10-19 06:51:58 |          0 |
|       3 |       2 | ユーザー2の投稿1        | 2023-10-19 06:51:58 |          0 |
+---------+---------+-------------------------+---------------------+------------+
3 rows in set (0.00 sec)

mysql> -- Likeテーブルのデータを取得--
Query OK, 0 rows affected (0.00 sec)

mysql> SELECT * FROM post_like;
+---------+---------+---------+
| like_id | user_id | post_id |
+---------+---------+---------+
|       1 |       1 |       3 |
|       2 |       2 |       1 |
|       3 |       1 |       3 |
+---------+---------+---------+
3 rows in set (0.00 sec)
```

もちろん、テーブルの構造とデータは相互に影響し合います。以下に、各テーブルの簡単な説明と、Like数が増えた場合に他のテーブルにどのような変化が生じるかについて説明します。

1. **ユーザーテーブル (userテーブル):**
   - ユーザーの情報を保持します。各ユーザーに一意のIDがあります。
   - このテーブルはユーザーのプロフィール情報などを保存します。

2. **投稿テーブル (postテーブル):**
   - ユーザーが行った投稿情報を保持します。各投稿に一意のIDがあり、投稿を行ったユーザーIDと関連づけられています。
   - また、投稿ごとにLike数を示す`like_count`カラムがありますが、初期値はゼロです。

3. **Likeテーブル (post_likeテーブル):**
   - Like情報を保持するための中間テーブルです。各Likeに一意のIDがあり、どのユーザーがどの投稿にLikeを付けたかを記録します。
   - ユーザーIDと投稿IDを関連づけることで、どの投稿に誰がLikeを付けたかを追跡します。

Like数が増えた場合、通常は以下のような変化が生じます：

- ユーザーが投稿にLikeを付けると、Likeテーブル (`post_like`テーブル) に新しいLikeのレコードが挿入されます。この新しいLike情報には、ユーザーIDと投稿IDが含まれます。

- Likeテーブルに新しいLikeが挿入されるたびに、該当の投稿の`like_count`カラムがインクリメントされるように、アプリケーションコードやトリガーを使用して更新することが一般的です。これにより、Like数が増えたことが投稿テーブル (`post`テーブル) に反映されます。

このように、Like数の増減はLikeテーブル (`post_like`テーブル) への新しいレコードの挿入および投稿テーブル (`post`テーブル) の`like_count`カラムの変更を伴います。この仕組みにより、Like情報を効果的に追跡し、Like数を管理できます。

postテーブルにlike数をつけてみる
```sql
-- 投稿テーブルにLike数をつける
INSERT INTO post (post_id, user_id, post_text, post_date, like_count)
VALUES
    (4, 4444, 'ユーザー4444の投稿1', NOW(), 1),
    (5, 5555, 'ユーザー5555の投稿2', NOW(), 0),
    (6, 6666, 'ユーザー6666の投稿1', NOW(), 2);

-- postテーブルのデータを取得 --
SELECT * FROM post;

-- post_likeテーブルのデータを取得 --
SELECT * FROM post_like;
```

## もし登録されているユーザーがいない場合は、外部キーの制約によりエラーが発生します。

エラーメッセージによれば、`INSERT INTO post`の際に外部キー制約が違反されたため、挿入が失敗しました。外部キー制約は、`post`テーブルの`user_id`カラムに対して`user`テーブルの`user_id`カラムを参照していることを確認しています。つまり、`post`テーブルに挿入しようとしているユーザーID（`user_id`）が、`user`テーブルに存在しないか、または無効である可能性があります。

エラーメッセージにあるように、外部キー制約が失敗している理由は、`user_id`が`user`テーブルに存在しない値を指している可能性があるためです。`INSERT INTO post`の際に指定したユーザーID（4444、5555、6666）が、`user`テーブルに存在しないか、正しいユーザーIDでない可能性があります。

解決策として、以下の点を確認してください：

1. `user`テーブルに、指定したユーザーID（4444、5555、6666）が存在するか確認します。存在しない場合は、まずユーザー情報を`user`テーブルに挿入する必要があります。

2. ユーザーID（`user_id`）が正しいか確認します。誤って存在しないユーザーIDを指定した場合、正しいユーザーIDを使用して再度挿入してみてください。

正しいユーザーIDを使用して投稿を挿入することで、外部キー制約違反を回避できるはずです。

## ダミーのユーザーを追加する
ユーザー3と4を追加する
```sql
-- ダミーユーザーデータを挿入
INSERT INTO user (user_id, username, profile_info)
VALUES
    (3, 'ユーザー3', 'ユーザー3のプロフィール情報'),
    (4, 'ユーザー4', 'ユーザー4のプロフィール情報');

-- ダミー投稿データを挿入
INSERT INTO post (post_id, user_id, post_text, post_date)
VALUES
    (4, 3, 'ユーザー3の投稿1', NOW()),
    (5, 3, 'ユーザー3の投稿2', NOW()),
    (6, 4, 'ユーザー4の投稿1', NOW());

-- like_countが入ってなかったので更新をする --
UPDATE post SET like_count = 1 WHERE post_id = 4;
UPDATE post SET like_count = 0 WHERE post_id = 5;
UPDATE post SET like_count = 2 WHERE post_id = 6;

-- post_likeテーブルのデータを挿入
INSERT INTO post_like (like_id, user_id, post_id)
VALUES
    (4, 3, 6),
    (5, 4, 4),
    (6, 3, 6);

-- post_likeテーブルのデータを取得
SELECT * FROM post_like;
```