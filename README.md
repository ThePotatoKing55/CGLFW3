# CGLFW3

Builds [GLFW](https://www.glfw.org) as a library to add to your Swift Package. As of writing, it's currently updated to the [latest commit](https://github.com/glfw/glfw/commit/955fbd9d265fa95adf9cb94896eb9a516aa50420) for GLFW 3.4.

This package can work on its own, but it was created as a base for [SwiftGLFW](https://github.com/thepotatoking55/SwiftGLFW).

## Getting Started

SwiftPM doesn't support unsafe flags with semantic versioned packages, so add this to your dependecies in `Package.swift`:

```swift
.package(url: "https://github.com/thepotatoking55/CGLFW3.git", branch: "main")
```

From there, you can just import it with `import CGLFW3` and use it like normal.

## Cross-Platform Support

To expose platform-native functions such as `glfwGetCocoaWindow`, add the following C settings to your target:

```swift
.target(
    name: "ExampleTarget",
    dependencies: ["CGLFW3"],
    cSettings: [
        .define("GLFW_EXPOSE_NATIVE_WIN32", .when(platforms: [.windows])),
        .define("GLFW_EXPOSE_NATIVE_WGL", .when(platforms: [.windows])),
        .define("GLFW_EXPOSE_NATIVE_COCOA", .when(platforms: [.macOS])),
        .define("GLFW_EXPOSE_NATIVE_NSGL", .when(platforms: [.macOS])),
        .define("GLFW_EXPOSE_NATIVE_X11", .when(platforms: [.linux]))
    ]
)
```

I don't have a computer running Linux and Windows support for SwiftPM is rudimentary, so this will probably still take some work to get ported to non-Mac platforms.

## Hello World

A Swift translation of the "hello world" program in [GLFW's documentation](https://www.glfw.org/documentation):

```swift
import CGLFW3

func main() {
    glfwInit()
    
    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 4)
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 1)
    glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GLFW_TRUE)
    glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE)
    
    guard let window = glfwCreateWindow(800, 600, "Hello World", nil, nil) else {
        let error = glfwGetError(nil)
        print(error)
        return
    }

    glfwMakeCurrentContext(window)
    while glfwWindowShouldClose(window) == GLFW_FALSE {
        glfwSwapBuffers(window)
        glfwPollEvents()
    }
    
    glfwTerminate()
}
```
