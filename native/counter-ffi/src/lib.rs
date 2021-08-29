
#[no_mangle]
pub extern "C" fn increment(val: i32) -> i32 {
    counter::increment(val)
}
