-module(my_tree).
-export([my_search/1,my_echo/1]).
-include_lib("kernel/include/file.hrl").

my_echo([])     -> io:format("~p~n", ["end"]);
my_echo([H|T])  -> 
                   case file:read_file_info(H) of
                        {ok, Facts} ->
                            {FileType} = {Facts#file_info.type},
                            io:format("~p~n", ([[H] ++ FileType])), %,io:format("~p~n", [FileType]),
                            my_echo(T);
                        _ ->
                            my_echo(T)
                   end.

my_search(Path) ->
    {ok, L} = file:list_dir(Path),
    my_echo(L).
