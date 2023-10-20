# 第3正規系
第２正規系だと、社員が誰もいない部署があるテーブルだと、部署名がNULLになってしまうので、データを登録することができない。
先ほどのemployeeテーブルを例にすると、部署名がNULLになってしまうので、データを登録することができない。
employee_idが主キーである以上、NULLのままレコードを登録することはできません。この中には隠れた関数従属が存在します。

- {部署コード} -> {部署名}

という関数従属が成立します。一方、社員IDと部署コードの間にも、当然のことながら、

- {会社コード, 社員 ID} -> {部署コード}

という関数従属が存在しています。つまり、全体としては、

- {会社コード , 社員 ID} -> {部署コード} -> {部署名}

という二段階での関数従属があるわけで、テーブル内部に存在する段階的な従属関係を推移的関数従属と呼びます。

## 第３正規化を行う
このような推移的関数従属を解消するために、第３正規系を適用します。第３正規系では、推移的関数従属を解消するために、テーブルを分割します。分割すると、以下のようになります。

employeeテーブル
```sql
CREATE TABLE employee (
  company_id CHAR(3) NOT NULL,
  employee_id CHAR(5) NOT NULL,
  employee_name VARCHAR(20) NOT NULL,
  age INTENGER NOT NULL,
  department_code CHAR(2) NOT NULL,
);
```

companyテーブル
```sql
CREATE TABLE company (
  company_id CHAR(3) NOT NULL,
  company_name VARCHAR(20) NOT NULL,
);
```

departmentテーブル
```sql
CREATE TABLE department (
  department_code CHAR(2) NOT NULL,
  department_name VARCHAR(20) NOT NULL,
);
```

このように、新しく部署を管理するテーブルを作成し、employeeテーブルから部署コードを削除します。これにより、推移的関数従属が解消され、第３正規系になります。
先ほど問題だった、部署名がNULLになってしまう問題も解消されます。departmentテーブルに登録するときには、社員の情報が必要ないからです。

このように、第３正規系も社員と部署という異なる実態を異なるテーブルとして切り分けてやる作業として見れば、第２正規系と同じ意味を持っています。

ここまでのことをまとめると、第２正規系の時は、社員がいないとテーブルに情報を登録できないが、第３正規系にすることで、社員がいなくても部署の情報を登録できるようになる。