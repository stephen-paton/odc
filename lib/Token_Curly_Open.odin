package lib

import "core:text/regex"

Token_Curly_Open :: struct {}

Token_Curly_Open__try_from_str :: proc(value: string) -> (token: Token_Curly_Open, err: Token__Err__try_from_str) {
    err = ._Ok

    matcher_regex, regex_err := regex.create_by_user(MATCHER_REGEX)
    if !(regex_err == regex.Compiler_Error.None || regex_err == regex.Creation_Error.None) do panic("Bad regex")
    defer regex.destroy_regex(matcher_regex)

    capture, success := regex.match_and_allocate_capture(matcher_regex, value)
    defer regex.destroy_capture(capture)

    if success {
        token = {}
    } else {
        err = ._FailedToMatch
    }
    
    return
}

@(private="file")
MATCHER_REGEX :: `/^\{/`
