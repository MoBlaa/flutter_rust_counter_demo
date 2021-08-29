use wasm_bindgen::prelude::*;

#[wasm_bindgen]
pub fn increment(val: i64) -> i64 {
    val.wrapping_add(1)
}
