.PHONY: build install

install:
	curl https://rustwasm.github.io/wasm-pack/installer/init.sh -sSf | sh
	cargo install cargo-ndk
	rustup target add \
        aarch64-linux-android \
        armv7-linux-androideabi \
        x86_64-linux-android \
        i686-linux-android

build:
	cargo ndk -o ./packages/counter/android/src/main/jniLibs build --release
	wasm-pack build --target web --out-dir=./../../packages/counter/pkg --no-typescript ./native/counter-wasm