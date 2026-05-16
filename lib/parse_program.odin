package lib

import "base:runtime"

@(private)
parse_program :: proc(token_index: ^int, token_list: TokenList, allocator: runtime.Allocator) -> (ast_item: ASTItem_Program, err: Err_Parse) {
	function_definition: ASTItem_Function
	function_definition, err = parse_function(token_index, token_list, allocator)
	if err == ._FailedToParse do return

	ast_item = { function_definition = function_definition }

	return
}
