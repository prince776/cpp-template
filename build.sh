#!/bin/sh

while getopts :c: flag
do
    case "${flag}" in
        c) config=${OPTARG};;
    esac
done

config="${config:-Debug}"
echo "Building with config: ${config}"

cmake -S . -B build -DCMAKE_BUILD_TYPE=$config
cd build
make
cd ..
cp build/compile_commands.json compile_commands.json
