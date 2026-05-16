package lib

import "core:fmt"
import "core:strconv"

@(private)
parse_expression :: proc(token_index: ^int, token_list: TokenList) -> (ast_item: ASTItem_Expression, err: Err_Parse) {
	err = expect(token_index, Token_Constant, token_list[token_index^])
	if err == ._FailedToParse do return

	token := token_list[token_index^ - 1].(Token_Constant)

	const_val, ok := strconv.parse_int(token.value)

	if !ok do fmt.panicf("odc bug (please report) :: Token_Constant's value '%v' should be guaranteed to successfully parse to an int. The fact that it hasn't means that something is wrong with either the regex used by the lexer to extract it, or within the body of the lexer itself.", token.value)

	ast_item = const_val

	return
}
