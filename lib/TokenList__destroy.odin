package lib

@(private)
TokenList__destroy :: proc(token_list: TokenList, allocator := context.allocator) {
    for token in token_list {
        #partial switch t in token {
            case Token_Identifier: delete(t.value)
            case Token_Constant: delete(t.value)
        }
    }

    delete(token_list)
}
