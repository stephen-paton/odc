package lib

Token :: union {
    IdentifierToken,
    ConstantToken,
    IntKeywordToken,
    VoidKeywordToken,
    ReturnKeywordToken,
    OpenParenToken,
    CloseParenToken,
    OpenCurlyToken,
    CloseCurlyToken,
    SemiColonToken,
}

Token__Err__try_from_str :: enum {
    _Ok,
    _FailedToMatch,
}

Token__len :: proc(token: Token) -> (length: int) {
    switch t in token {
        case IdentifierToken: length = len(t.value)
        case ConstantToken: length = len(t.value)
        case IntKeywordToken: length = 3
        case VoidKeywordToken: length = 4
        case ReturnKeywordToken: length = 6
        case OpenParenToken: length = 1
        case CloseParenToken: length = 1
        case OpenCurlyToken: length = 1
        case CloseCurlyToken: length = 1
        case SemiColonToken: length = 1
    }

    return
}
