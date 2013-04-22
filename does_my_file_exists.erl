-module(does_my_file_exists).
-export([check_my_file/0]).
-import(filelib, [is_file/1]).

% BUILD_SUCCESS という空ファイルが出来たら
% 遠隔のサーバに成功したことを伝えるスクリプトを作成する

check_my_file() ->
    io:format("~p~n", [is_file("BUILD_SUCCESS")]).
