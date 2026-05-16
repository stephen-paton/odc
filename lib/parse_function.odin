package lib

import "base:runtime"
import "core:strings"

@(private)
parse_function :: proc(token_index: ^int, token_list: TokenList, allocator: runtime.Allocator) -> (ast_item: ASTItem_Function, err: Err_Parse) {
	err = expect(token_index, Token_Keyword_Int, token_list[token_index^])
	if err == ._FailedToParse do return

	err = expect(token_index, Token_Identifier, token_list[token_index^], "main")
	if err == ._FailedToParse do return

	name: string = strings.clone(token_list[token_index^ - 1].(Token_Identifier).value, allocator)

	err = expect(token_index, Token_Paren_Open, token_list[token_index^])
	if err == ._FailedToParse {
		delete(name)
		return
	}

	err = expect(token_index, Token_Keyword_Void, token_list[token_index^])
	if err == ._FailedToParse {
		delete(name)
		return
	}

	err = expect(token_index, Token_Paren_Closed, token_list[token_index^])
	if err == ._FailedToParse {
		delete(name)
		return
	}

	err = expect(token_index, Token_Curly_Open, token_list[token_index^])
	if err == ._FailedToParse {
		delete(name)
		return
	}

	body: ASTItem_Statement
	body, err = parse_statement(token_index, token_list)
	if err == ._FailedToParse {
		delete(name)
		return
	}

	ast_item = { name = name, body = body }

	return
}
