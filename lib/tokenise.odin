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

        token, token_err = Token_Keyword_Int__try_from_str(sub_str)
        if token_err != ._Ok do token, token_err = Token_Keyword_Void__try_from_str(sub_str)
        if token_err != ._Ok do token, token_err = Token_Keyword_Return__try_from_str(sub_str)
        if token_err != ._Ok do token, token_err = Token_Paren_Open__try_from_str(sub_str)
        if token_err != ._Ok do token, token_err = Token_Paren_Closed__try_from_str(sub_str)
        if token_err != ._Ok do token, token_err = Token_Curly_Open__try_from_str(sub_str)
        if token_err != ._Ok do token, token_err = Token_Curly_Closed__try_from_str(sub_str)
        if token_err != ._Ok do token, token_err = Token_SemiColon__try_from_str(sub_str)
        if token_err != ._Ok do token, token_err = Token_Identifier__try_from_str(sub_str, allocator)
        if token_err != ._Ok do token, token_err = Token_Constant__try_from_str(sub_str, allocator)
        
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