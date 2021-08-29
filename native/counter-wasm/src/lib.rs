use wasm_bindgen::prelude::*;

#[wasm_bindgen]
pub fn increment(val: i32) -> i32 {
    counter::increment(val)
}
