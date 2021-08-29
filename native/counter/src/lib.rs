pub fn increment(val: i64) -> i64 {
    val.wrapping_add(1)
}

#[cfg(test)]
mod tests {
    #[test]
    fn it_works() {
        assert_eq!(super::increment(1), 2);
    }
}
