# MacのMySQLを操作する

homebrewでインストールしたMySQLを操作する方法をまとめます。

## MySQLのインストール
```bash
$ brew install mysql
```

## MySQLの起動
```bash
$ mysql.server start
```

## MySQLの停止
```bash
$ mysql.server stop
```

## MySQLの再起動
```bash
$ mysql.server restart
```

## MySQLのログイン
私の場合は、1234をパスワードに設定しています。
```bash
$ mysql -u root -p
```