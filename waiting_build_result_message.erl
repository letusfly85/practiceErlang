-module(waiting_build_result_message).
-export([loop/0, rpc/2, start/0]).

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
