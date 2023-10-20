-- 生徒の名前と点数のテーブルを作成する --
CREATE TABLE IF NOT EXISTS student_score (
    name TEXT,
    score INTEGER
);

-- テーブルにデータを挿入する --
INSERT INTO student_score (name, score) VALUES ('鈴木', 92);
INSERT INTO student_score (name, score) VALUES ('佐藤', 74);
INSERT INTO student_score (name, score) VALUES ('山田', 43);
INSERT INTO student_score (name, score) VALUES ('田中', 65);
INSERT INTO student_score (name, score) VALUES ('中村', 80);
INSERT INTO student_score (name, score) VALUES ('小林', 58);

-- window関数を使って、点数の順位を求める --
-- 使い方: ウィンドウ関数 OVER([PARTITION BY 列名] [ORDER BY 列名 [ASC|DESC]] [{ROWS|RANGE} フレーム指定])
SELECT
    name,
    score,
    RANK() OVER(ORDER BY score DESC) AS `rank`
FROM
    student_score
ORDER BY
    `rank`;
