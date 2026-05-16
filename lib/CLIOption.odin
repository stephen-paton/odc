package lib

CLIOption :: enum {
    _Lex,
    _Parse,
    _Codegen,
    _Assembly
}

CLIOption__try_from_str :: proc(value: string) -> (option: CLIOption, err: Err_TryFrom) {
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
