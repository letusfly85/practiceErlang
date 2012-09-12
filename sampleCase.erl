-module (sampleCase).
-export ([sampleCase/1]).

sampleCase(Animal) ->
    case Animal of
            "dog"  -> underdog;
            "cat"  -> thundercat
    end.
