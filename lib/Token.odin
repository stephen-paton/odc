package lib

Token :: union {
    Token_Identifier,
    Token_Constant,
    Token_Keyword_Int,
    Token_Keyword_Void,
    Token_Keyword_Return,
    Token_Paren_Open,
    Token_Paren_Closed,
    Token_Curly_Open,
    Token_Curly_Closed,
    Token_SemiColon,
}

Token__Err__try_from_str :: enum {
    _Ok,
    _FailedToMatch,
}

Token__len :: proc(token: Token) -> (length: int) {
    switch t in token {
        case Token_Identifier: length = len(t.value)
        case Token_Constant: length = len(t.value)
        case Token_Keyword_Int: length = 3
        case Token_Keyword_Void: length = 4
        case Token_Keyword_Return: length = 6
        case Token_Paren_Open: length = 1
        case Token_Paren_Closed: length = 1
        case Token_Curly_Open: length = 1
        case Token_Curly_Closed: length = 1
        case Token_SemiColon: length = 1
    }

    return
}
