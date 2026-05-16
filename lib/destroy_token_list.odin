package lib

destroy_token_list :: proc(token_list: [dynamic]Token, allocator := context.allocator) {
    for token in token_list {
        #partial switch t in token {
            case IdentifierToken: delete(t.value)
            case ConstantToken: delete(t.value)
        }
    }

    delete(token_list)
}
