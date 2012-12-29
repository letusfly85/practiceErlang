-module (myrecord).
-export ([clear_status/1]).

-record (todo, {status=reminder, who=joe, text}).
-record (name, {
                key1 = default1,
                key2 = default2
            }).

clear_status(#todo{status=S, who=W} = R) ->
    R#todo{status=finished}.

%do_something(X) when is_record(X, todo)
