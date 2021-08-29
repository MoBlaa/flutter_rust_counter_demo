.PHONE: build install

install:
	cargo install cargo-ndk
	rustup target add \
        aarch64-linux-android \
        armv7-linux-androideabi \
        x86_64-linux-android \
        i686-linux-android

build:
	cargo ndk -o ./target/jniLibs build --release