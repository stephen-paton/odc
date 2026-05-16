package lib

Option :: enum {
    _Lex,
    _Parse,
    _Codegen,
    _Assembly
}

Option__Err__try_from_str :: enum {
    _Ok,
    _FailedToConvert,
}

Option__try_from_str :: proc(value: string) -> (option: Option, err: Option__Err__try_from_str) {
    err = ._Ok

    switch (value) {
        case "--lex": option = ._Lex
        case "--parse": option = ._Parse
        case "--codegen": option = ._Codegen
        case "-S": option = ._Assembly
        case: err = ._FailedToConvert
    }

    return
}
