# CGLFW3

Builds [GLFW](https://www.glfw.org) as a library to add to your Swift Package. As of writing, it's currently updated to the [latest commit](https://github.com/glfw/glfw/commit/955fbd9d265fa95adf9cb94896eb9a516aa50420) for GLFW 3.4.

This package can work on its own, but it was created as a base for [SwiftGLFW](https://github.com/thepotatoking55/SwiftGLFW).

## Getting Started

Add to your dependecies in `Package.swift`:

```swift
.package(url: "https://github.com/thepotatoking55/CGLFW3", .branch("main"))
```

From there, you can just import it with `import CGLFW3` and use it like normal.

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
