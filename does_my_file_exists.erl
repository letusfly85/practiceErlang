-module(does_my_file_exists).
-export([check_my_file/0, loop/0, rrpc/2, start/0, hello/0, touch_my_file/2]).
-import(filelib, [is_file/1]).

% BUILD_SUCCESS という空ファイルが出来たら
% 遠隔のサーバに成功したことを伝えるスクリプトを作成する
%

hello() ->
    io:format("~p~n", ["hello"]).

touch_my_file(File, Message) ->
    {ok, S} = file:open(File, write),
    io:format(S, "~p~n", [Message]),
    file:close(S).

check_my_file() ->
    case is_file("BUILD_SUCCESS") of
        true  ->
            rrpc(checker, {build_success, "build success!"});
        false ->
            rrpc(checker, {build_failure, "build failure!"})
    end.

rrpc(Pid, Request) ->
    Pid ! {self(), Request},
    receive
        {Pid, Response} ->
            Response
    end.

start() ->
    spawn(fun loop/0).
    %register(checker, Pid).

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
