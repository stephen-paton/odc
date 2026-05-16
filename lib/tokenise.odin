package lib

import "core:fmt"

tokenise__Err :: enum {
    _Ok,
    _NoCorrespondingToken,
}

tokenise :: proc(c_source_code: string, allocator := context.allocator) -> (token_list: [dynamic]Token, err: tokenise__Err) {
    err = ._Ok

    skip_count: int

    for r, i in c_source_code {
        if skip_count > 0 {
            skip_count -= 1
            continue
        }

        if r == ' ' do continue
        if r == '\n' do continue
        if r == '\r' do continue
        if r == '\t' do continue

        sub_str := c_source_code[i:]

        token: Token
        token_err: Token__Err__try_from_str = ._FailedToMatch

        token, token_err = IntKeywordToken__try_from_str(sub_str)
        if token_err != ._Ok do token, token_err = VoidKeywordToken__try_from_str(sub_str)
        if token_err != ._Ok do token, token_err = ReturnKeywordToken__try_from_str(sub_str)
        if token_err != ._Ok do token, token_err = OpenParenToken__try_from_str(sub_str)
        if token_err != ._Ok do token, token_err = CloseParenToken__try_from_str(sub_str)
        if token_err != ._Ok do token, token_err = OpenCurlyToken__try_from_str(sub_str)
        if token_err != ._Ok do token, token_err = CloseCurlyToken__try_from_str(sub_str)
        if token_err != ._Ok do token, token_err = SemiColonToken__try_from_str(sub_str)
        if token_err != ._Ok do token, token_err = IdentifierToken__try_from_str(sub_str, allocator)
        if token_err != ._Ok do token, token_err = ConstantToken__try_from_str(sub_str, allocator)
        
        if token_err != ._Ok {
            err = ._NoCorrespondingToken
            return
        }

        append(&token_list, token)
        skip_count = Token__len(token) - 1
    }

    shrink(&token_list)
    
    return
}