-- データベースを作成 --
CREATE DATABASE db_design;

-- 社員テーブルを作成 --
CREATE TABLE IF NOT EXISTS `employee` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` varchar(30) NOT NULL,
  `employee_name` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 社員テーブルにデータを挿入 --
INSERT INTO `employee` (`id`, `employee_id`, `employee_name`) VALUES
(1, '0001', '山田太郎'),
(2, '0002', '鈴木一郎'),
(3, '0003', '佐藤花子'),
(4, '0004', '田中次郎'),
(5, '0005', '山本三郎');

-- 扶養者テーブルを作成 --
CREATE TABLE IF NOT EXISTS `dependent` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` varchar(30) NOT NULL,
  `child_name` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 扶養者テーブルにデータを挿入 --
INSERT INTO `dependent` (`id`, `employee_id`, `child_name`) VALUES
(1, '0001', '山田花子'),
(2, '0001', '山田次郎'),
(3, '0002', '鈴木花子'),
(4, '0002', '鈴木次郎'),
(5, '0003', '佐藤花子'),
(6, '0003', '佐藤次郎'),
(7, '0003', '佐藤三郎'),
(8, '0004', '田中花子'),
(9, '0004', '田中次郎'),
(10, '0004', '田中三郎');

-- 社員テーブルと扶養者テーブルを内部結合 --
SELECT
  e.employee_id,
  e.employee_name,
  d.child_name
FROM
  employee e
INNER JOIN
  dependent d
ON
  e.employee_id = d.employee_id;

-- 外部結合 --
SELECT
  e.employee_id,
  e.employee_name,
  d.child_name
FROM
  employee e
LEFT OUTER JOIN
  dependent d
ON
  e.employee_id = d.employee_id;