-module(generate_multi_files).
-compile(export_all).
-import(filename).

generate_file(File, X) ->
        {ok, S} = file:open(File, write),
        io:format(S, "~p~n", [X]),
        file:close(S).

generate_multi_files(Max, Max) -> io:format("~p~n",["end"]);
generate_multi_files(Max, N  ) ->
    FileID   = integer_to_list(N),
    FileName = filename:absname_join("output", string:concat(FileID, ".dat")),
    io:format("~p~n", [FileName]),
    generate_file(FileName, N),
    generate_multi_files(Max, N + 1).
