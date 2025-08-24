import in

pub fn main() {
  // $ echo -e "line 1\nline 2\nline 3\nline 4" | gleam test
  let assert Ok(line1) = in.read_line()
  echo line1
  // "line 1\n"

  let assert Ok(line2) = in.read_chars(7)
  echo line2
  // "line 2\n"

  // If the number of characters requested is greater than the stdin length,
  // the function will return everything up to the end of the file.
  let assert Ok(rest) = in.read_chars(28)
  echo rest
  // "line 3\nline 4\n"

  // If you try to read beyond the end of the file,
  // the function will return an Error(Eof).
  let assert Error(eof) = in.read_chars(1)
  echo eof
  // Eof
}
