package main

import "core:fmt"
import "core:os"
import "core:strings"

import "lib"

main :: proc() {
    args := os.args
    args_len := len(args)

    c_file_path: string
    maybe_option: Maybe(lib.CLIOption)

    if args_len < 2 {
        panic("Too few args provided")
    } else if args_len == 2 {
        c_file_path = args[1]
    } else if args_len == 3 {
        option, err := lib.CLIOption__try_from_str(args[1])
        if err == ._Ok do maybe_option = option
        c_file_path = args[2]
    } else {
        panic("Too many args provided")
    }

    if !strings.ends_with(c_file_path, ".c") do fmt.panicf("\"%v\" is not a valid path c file path", c_file_path)
    if !os.is_file(c_file_path) do fmt.panicf("\"%v\" is not a valid c file", c_file_path)

    i_file_path := fmt.aprintf("%v.i", c_file_path[0:len(c_file_path) - 2])
    defer delete(i_file_path)
    fmt.printfln("i_file_path: %v", i_file_path)

    state, stdout, stderr, _ := os.process_exec({ command = { "gcc", "-E", "-P", c_file_path, "-o", i_file_path }}, allocator = context.allocator)
    defer delete(stdout)
    defer delete(stderr)

    if !state.success do panic("Failed to pre-process c file")
    defer os.remove(i_file_path)

    c_source_code, read_err := os.read_entire_file(i_file_path, context.allocator)
    if read_err != nil do panic("Failed to read .i file")
	defer delete(c_source_code)

    // s_file_path := fmt.aprintf("%v.s", c_file_path[0:len(c_file_path) - 2])
    // defer delete(s_file_path)
    
    // output_file_path := c_file_path[0:len(c_file_path) - 2]

    // _, stdout, stderr, _ = os.process_exec({ command = { "gcc", s_file_path, "-o", output_file_path }}, allocator = context.allocator)
    // defer delete(stdout)
    // defer delete(stderr)
}
