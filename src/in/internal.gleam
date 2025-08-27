pub type IoDevice {
  StandardIo
}

pub type IoResult(t, e) {
  Ok(t)
  Eof
  Error(e)
}

@external(erlang, "file", "read")
pub fn ffi_read(device: IoDevice, number: Int) -> IoResult(t, e)

@external(erlang, "file", "read_line")
pub fn ffi_read_line(device: IoDevice) -> IoResult(t, e)
