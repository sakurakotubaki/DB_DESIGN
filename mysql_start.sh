#!/bin/bash

# MySQLを起動する
mysql.server start

# 起動が成功したかどうかを確認する
if [ $? -eq 0 ]; then
    echo "MySQLが正常に起動しました。"
else
    echo "MySQLの起動に失敗しました。エラーコード: $?"
fi
