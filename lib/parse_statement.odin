package lib

@(private)
parse_statement :: proc(token_index: ^int, token_list: TokenList) -> (ast_item: ASTItem_Statement, err: Err_Parse) {
	err = expect(token_index, Token_Keyword_Return, token_list[token_index^])
	if err == ._FailedToParse do return

	expression: ASTItem_Expression
	expression, err = parse_expression(token_index, token_list)

	err = expect(token_index, Token_SemiColon, token_list[token_index^])
	if err == ._FailedToParse do return

	ast_item = ASTItem_Return { expression = expression }

	return
}
