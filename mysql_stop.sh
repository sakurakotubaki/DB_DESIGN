#!/bin/bash

# MySQLを停止する
mysql.server stop

# 起動が成功したかどうかを確認する
if [ $? -eq 0 ]; then
    echo "MySQLが正常に停止しました。"
else
    echo "MySQLの停止に失敗しました。エラーコード: $?"
fi
