package lib

parse :: proc(token_list: TokenList, allocator := context.allocator) -> (ast: ASTItem_Program, err: Err_Parse) {
	token_index := 0
	ast, err = parse_program(&token_index, token_list)
	return
}
