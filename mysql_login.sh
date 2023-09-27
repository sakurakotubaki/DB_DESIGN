#!/bin/bash

# MySQLにログインする
mysql.server start --skip-grant-tables

# 正常にログインできたかどうかを確認する
if [ $? -eq 0 ]; then
    echo "MySQLに正常にログインできました。"
else
    echo "MySQLのログインに失敗しました。エラーコード: $?"
fi