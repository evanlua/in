/// The `in` module provides functions to read input from the standard I/O device
/// with proper error handling and encoding support.
///
/// It wraps Erlang's `file:read/2` and `file:read_line/1` functions
///
import in/internal.{type IoResult, StandardIo}

/// Represents supported text encodings for input operations.
///
pub type Encoding {
  Latin1
  Unicode
  Utf8
  Utf16
  Utf32
}

/// Represents all possible errors that can occur during input operations.
///
pub type Error {
  // End of input (EOF) reached before reading anything
  Eof
  // Invalid argument passed to the input function
  Badarg
  // The input process was terminated unexpectedly
  Terminated
  // Error when converting between encodings
  NoTranslation(Encoding, Encoding)
  // POSIX file-related errors
  Eacces
  Eagain
  Ebadf
  Ebadmsg
  Ebusy
  Edeadlk
  Edeadlock
  Edquot
  Eexist
  Efault
  Efbig
  Eftype
  Eintr
  Einval
  Eio
  Eisdir
  Eloop
  Emfile
  Emlink
  Emultihop
  Enametoolong
  Enfile
  Enobufs
  Enodev
  Enolck
  Enolink
  Enoent
  Enomem
  Enospc
  Enosr
  Enostr
  Enosys
  Enotblk
  Enotdir
  Enotsup
  Enxio
  Eopnotsupp
  Eoverflow
  Eperm
  Epipe
  Erange
  Erofs
  Espipe
  Esrch
  Estale
  Etxtbsy
  Exdev
}

/// Converts an internal `IoResult(String, Error)`
/// returned by the FFI into a `Result(String, Error)`.
///
fn ioresult_to_result(ffi: IoResult(String, Error)) -> Result(String, Error) {
  case ffi {
    internal.Ok(s) -> Ok(s)
    internal.Eof -> Error(Eof)
    internal.Error(e) -> Error(e)
  }
}

/// Reads up to `number` characters from the standard input.
///
/// If the requested number of characters exceeds the available input,
/// returns everything until the end of input.
///
pub fn read_chars(number: Int) -> Result(String, Error) {
  internal.ffi_read(StandardIo, number)
  |> ioresult_to_result()
}

/// Reads a line from the standard input.
///
pub fn read_line() -> Result(String, Error) {
  internal.ffi_read_line(StandardIo)
  |> ioresult_to_result()
}
