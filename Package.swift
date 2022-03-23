// swift-tools-version:5.3

import PackageDescription

extension Array where Element == String {
    func sourcify() -> [String] {
        return map("src/".appending)
    }
}

var cSettings: [CSetting] = [.unsafeFlags(["-fno-objc-arc"])]

var sources: [String] = [
    "internal.h", "platform.h", "mappings.h",
    "context.c", "init.c", "input.c", "monitor.c", "platform.c", "vulkan.c", "window.c",
    "egl_context.c", "osmesa_context.c", "null_platform.h", "null_joystick.h",
    "null_init.c", "null_monitor.c", "null_window.c", "null_joystick.c"
]

#if os(macOS)
// Cocoa/NSGL
sources += [
    "cocoa_time.h", "cocoa_time.c", "posix_thread.h",
    "posix_module.c", "posix_thread.c"
]

sources += [
    "cocoa_platform.h", "cocoa_joystick.h", "cocoa_init.m",
    "cocoa_joystick.m", "cocoa_monitor.m", "cocoa_window.m",
    "nsgl_context.m"
]

cSettings += [
    .define("GLFW_EXPOSE_NATIVE_COCOA", .when(platforms: [.macOS])),
    .define("GLFW_EXPOSE_NATIVE_NSGL", .when(platforms: [.macOS])),
    .define("_GLFW_COCOA", .when(platforms: [.macOS]))
]
#elseif os(Windows)
// Win32/WGL
sources += [
    "win32_time.h", "win32_thread.h", "win32_module.c",
    "win32_time.c", "win32_thread.c"
]

sources += [
    "win32_platform.h", "win32_joystick.h", "win32_init.c",
    "win32_joystick.c", "win32_monitor.c", "win32_window.c",
    "wgl_context.c"
]

cSettings += [
    .define("GLFW_EXPOSE_NATIVE_WIN32", .when(platforms: [.windows])),
    .define("GLFW_EXPOSE_NATIVE_WGL", .when(platforms: [.windows])),
    .define("_GLFW_WIN32", .when(platforms: [.windows]))
]
#else
// Linux/X11
sources += [
    "posix_time.h", "posix_thread.h", "posix_module.c",
    "posix_time.c", "posix_thread.c",
    "linux_joystick.h", "linux_joystick.c",
    "posix_poll.h", "posix_poll.c"
]

sources += [
    "x11_platform.h", "xkb_unicode.h", "x11_init.c",
    "x11_monitor.c", "x11_window.c", "xkb_unicode.c",
    "glx_context.c"
]

cSettings += [
    .define("GLFW_EXPOSE_NATIVE_X11", .when(platforms: [.linux])),
    .define("_GLFW_X11", .when(platforms: [.linux])),
    .define("_DEFAULT_SOURCE", .when(platforms: [.linux]))
]
#endif

let package = Package(
    name: "CGLFW3",
    products: [
        .library(name: "CGLFW3", targets: ["CGLFW3"])
    ],
    targets: [
        .target(
            name: "glfw3",
            exclude: [
                "CMake",
                "deps", "docs", "examples", "tests",
                "CMakeLists.txt", "LICENSE.md", "README.md",
                "src/CMakeLists.txt"
            ],
            sources: sources.sourcify() + ["include"],
            publicHeadersPath: "include",
            cSettings: [
                .headerSearchPath("src"),
                .headerSearchPath("include"),
                .define("GLFW_EXPOSE_NATIVE_COCOA", .when(platforms: [.macOS])),
                .define("GLFW_EXPOSE_NATIVE_NSGL", .when(platforms: [.macOS])),
                .define("_GLFW_COCOA", .when(platforms: [.macOS])),
                .define("GLFW_EXPOSE_NATIVE_WIN32", .when(platforms: [.windows])),
                .define("GLFW_EXPOSE_NATIVE_WGL", .when(platforms: [.windows])),
                .define("_GLFW_WIN32", .when(platforms: [.windows])),
                .define("GLFW_EXPOSE_NATIVE_X11", .when(platforms: [.linux])),
                .define("_GLFW_X11", .when(platforms: [.linux])),
                .define("_DEFAULT_SOURCE", .when(platforms: [.linux])),
                .unsafeFlags(["-fno-objc-arc"])
            ],
            linkerSettings: [
                .linkedFramework("Cocoa", .when(platforms: [.macOS])),
                .linkedFramework("IOKit", .when(platforms: [.macOS])),
                .linkedFramework("CoreFoundation", .when(platforms: [.macOS]))
            ]
        ),
        .target(
            name: "CGLFW3",
            dependencies: ["glfw3"]
        ),
        .testTarget(name: "CGLFW3Tests", dependencies: ["CGLFW3"])
    ]
)
