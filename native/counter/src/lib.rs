use std::sync::{Arc, Mutex};

pub fn increment(val: i32) -> i32 {
    val.wrapping_add(1)
}

lazy_static::lazy_static! {
    static ref CURRENT_VALUE: Arc<Mutex<i32>> = Arc::new(Mutex::new(0));
}

pub fn count() -> i32 {
    let mut lock = CURRENT_VALUE
        .lock()
        .expect("failed to get lock on current value");
    let next = lock.wrapping_add(1);
    *lock = next;
    next
}

#[cfg(test)]
mod tests {
    #[test]
    fn it_works() {
        assert_eq!(super::increment(1), 2);
    }
}
