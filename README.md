# CGLFW3

Links the [GLFW](https://www.glfw.org) static library to your Swift Package.

This package can work on its own as a C library, but it was created as a base for the wrapper library [SwiftGLFW](https://github.com/thepotatoking55/SwiftGLFW).

## Installation

Add to your `Package.swift` dependencies:

    .package(url: "https://github.com/thepotatoking55/CGLFW3.git", .upToNextMajor(from: "3.3.4"))
    
In your main code:

    import glfw3

## Updating

I can't guarantee this will always be up-to-date with the latest version of GLFW, but you can replace the headers in `Sources/CGLFW3/include/GLFW/` and the static library file at `Sources/CGLFW3/lib/libglfw3.a`. The macOS static library binaries can be downloaded [from the GLFW website](https://glfw.org/download).
