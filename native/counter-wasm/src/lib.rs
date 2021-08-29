use wasm_bindgen::prelude::*;
use std::sync::{Mutex, Arc};

#[wasm_bindgen]
pub fn increment(val: i32) -> i32 {
    counter::increment(val)
}

#[wasm_bindgen]
pub fn count() -> i32 {
    counter::count()
}