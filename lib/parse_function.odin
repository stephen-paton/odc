package lib

@(private)
parse_function :: proc(token_index: ^int, token_list: TokenList) -> (ast_item: ASTItem_Function, err: Err_Parse) {
	err = expect(token_index, Token_Identifier, token_list[token_index^])
	if err == ._FailedToParse do return

	

	return
}
