# BGLTF
Beef bindings for [cgltf](https://github.com/jkuhlmann/cgltf).

Binaries are included for Windows and in the future for Linux for the sake of convenience .

## Building
Enter the `Native` directory and run:
```shell
$ cmake -S . -B cmake-build
$ cmake --build cmake-build --config Debug
$ cmake --build cmake-build --config Release
```

These commands will build and copy both Debug/Release binaries under `dist/` with the appropriate name for Windows and Linux.