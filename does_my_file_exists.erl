-module(does_my_file_exists).
-export([check_my_file/1, loop/0, rpc/2, start/0]).
-import(filelib, [is_file/1]).

% BUILD_SUCCESS という空ファイルが出来たら
% 遠隔のサーバに成功したことを伝えるスクリプトを作成する

check_my_file(Pid) ->
    case is_file("BUILD_SUCCESS") of
        true  ->
            rpc(Pid, {build_success, "build success!"});
        false ->
            rpc(Pid, {build_failure, "build failure!"})
    end.

rpc(Pid, Request) ->
    Pid ! {self(), Request},
    receive
        {Pid, Response} ->
            Response
    end.

start() -> spawn(fun loop/0).

loop() ->
    receive
        {From ,{build_success, Message}} ->
            From ! {self(),    Message},
            loop();
        {From, {build_error,   Message}} ->
            From ! {self(),    Message},
            loop();
        {From, Other} ->
            From ! {self(), {error, Other}},
            loop()
    end.
