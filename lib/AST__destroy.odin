package lib

AST__destroy :: proc(ast: AST) {
    delete(ast.function_definition.name)
}
