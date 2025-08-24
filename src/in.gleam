import gleam/dynamic.{type Dynamic}
import gleam/dynamic/decode
import gleam/result

// Errors that occur when trying to read beyond the end of the file.
//
pub type IoError {
  Eof
}

@external(erlang, "io", "get_line")
fn ffi_get_line(prompt: String) -> Dynamic

// Reads a line from stdin.
// Returns an `Eof` error if you try to read beyond the end of the file.
//
pub fn read_line() -> Result(String, IoError) {
  ffi_get_line("")
  |> decode.run(decode.string)
  |> result.replace_error(Eof)
}

@external(erlang, "io", "get_chars")
fn ffi_get_chars(prompt: String, count: Int) -> Dynamic

// Reads up to `count` characters from stdin.
// If `count` is greater than the stdin length
// the function will return everything up to the end of the input.
// Returns an `Eof` error if you try to read beyond the end of the file.
//
pub fn read_chars(count: Int) -> Result(String, IoError) {
  ffi_get_chars("", count)
  |> decode.run(decode.string)
  |> result.replace_error(Eof)
}
