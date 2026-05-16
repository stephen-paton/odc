package lib

import "core:strings"
import "core:text/regex"

Token_Constant :: struct {
    value: string,
}

Token_Constant__try_from_str :: proc(value: string, allocator := context.allocator, loc := #caller_location) -> (token: Token_Constant, err: Err_TryFrom) {
    err = ._Ok

    matcher_regex, regex_err := regex.create_by_user(MATCHER_REGEX,)
    if !(regex_err == regex.Compiler_Error.None || regex_err == regex.Creation_Error.None) do panic("Bad regex")
    defer regex.destroy_regex(matcher_regex)

    capture, success := regex.match_and_allocate_capture(matcher_regex, value)
    defer regex.destroy_capture(capture)

    if success {
        token = {
            value = strings.clone(capture.groups[0], allocator = allocator, loc = loc)
        }
    } else {
        err = ._FailedToConvert
    }

    return
}

@(private="file")
MATCHER_REGEX :: `/^[0-9]+\b/`
