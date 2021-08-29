
#[no_mangle]
pub extern "C" fn increment(val: i64) -> i64 {
    counter::increment(val)
}
