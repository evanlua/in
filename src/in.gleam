import gleam/dynamic.{type Dynamic}
import gleam/dynamic/decode
import gleam/result
import gleam/string_tree.{type StringTree}

@external(erlang, "io", "get_line")
fn ffi_get_line(prompt: String) -> Dynamic

fn get_line() -> String {
  ffi_get_line("")
  |> decode.run(decode.string)
  |> result.unwrap("EOF")
}

fn get_line_acc(acc: StringTree) -> StringTree {
  let line = get_line()
  case line {
    "EOF" -> acc
    _ -> get_line_acc(string_tree.append(acc, line))
  }
}

/// Reads until EOF from stdin.
pub fn read() -> String {
  string_tree.new()
  |> get_line_acc()
  |> string_tree.to_string()
}
