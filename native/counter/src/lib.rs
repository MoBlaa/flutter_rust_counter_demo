pub fn increment(val: i32) -> i32 {
    val.wrapping_add(1)
}

#[cfg(test)]
mod tests {
    #[test]
    fn it_works() {
        assert_eq!(super::increment(1), 2);
    }
}
