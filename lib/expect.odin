package lib

import "core:fmt"
import "core:reflect"

@(private)
expect :: proc(token_index: ^int, expected_token_type: typeid, actual_token: Token, expected_value: Maybe(string) = nil) -> (err: Err_Parse) {
	err = ._Ok

	if expected_token_type != reflect.union_variant_typeid(actual_token) {
		err = ._FailedToParse
		return
	}

	if expected_value != nil {
		#partial switch t in actual_token {
			case Token_Identifier:
				if t.value != expected_value {
					err = ._FailedToParse
					return
				}
			case Token_Constant:
				if t.value != expected_value {
					err = ._FailedToParse
					return
				}
			case: fmt.panicf("odc bug (please report) :: An 'expected_value' has been passed to the expect proc, for the '%v' token variant, which is value-less", t);
		}
	}

	if err == ._Ok do token_index^ += 1

	return
}
