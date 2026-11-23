LLVM_MINGW_PATH := $$HOME/opt/llvm-mingw-20261020-ucrt-ubuntu-22.04-x86_64

all: mikuterm-x64 mikuterm-x86 mikuterm-arm64

submodule:
	git submodule update --init --recursive
	git submodule update --init --remote --recursive

mikuterm-x64: submodule
	@echo "Building mikuterm for Windows 11 x64..."
	rm -rf build/mikuterm-x64
	cmake -S external/zedBSD/apps/terminal-win32 -B build/mikuterm-x64 -G Ninja -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_TOOLCHAIN_FILE=cmake/llvm-mingw-x86_64.cmake -DLLVM_MINGW=$(LLVM_MINGW_PATH)
	cmake --build build/mikuterm-x64 --target zip

mikuterm-x86: submodule
	@echo "Building mikuterm for Windows 11 x86..."
	rm -rf build/mikuterm-x86
	cmake -S external/zedBSD/apps/terminal-win32 -B build/mikuterm-x86 -G Ninja -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_TOOLCHAIN_FILE=cmake/llvm-mingw-x86.cmake -DLLVM_MINGW=$(LLVM_MINGW_PATH)
	cmake --build build/mikuterm-x64 --target zip

mikuterm-arm64: submodule
	@echo "Building mikuterm for Windows 11 arm64..."
	rm -rf build/mikuterm-arm64
	cmake -S external/zedBSD/apps/terminal-win32 -B build/mikuterm-arm64 -G Ninja -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_TOOLCHAIN_FILE=cmake/llvm-mingw-aarch64.cmake -DLLVM_MINGW=$(LLVM_MINGW_PATH)
	cmake --build build/mikuterm-arm64 --target zip
