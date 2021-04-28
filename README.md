# CGLFW3

Links the [GLFW](https://www.glfw.org) static library to your Swift Package.

While this is 

## Installation

Add to your `Package.swift` dependencies:

    .package(url: "https://github.com/thepotatoking55/CGLFW3.git", .upToNextMajor(from: "3.3.4"))

## Updating

I can't guarantee this will always be up-to-date with the latest version of GLFW, but you can replace the headers in `Sources/GLFW/include/GLFW/` and the static library file at `Sources/GLFW/lib/libglfw3.a`. The macOS static library binaries can be downloaded [from the GLFW website](https://glfw.org/download).
