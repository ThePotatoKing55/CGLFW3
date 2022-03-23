import XCTest
@testable import CGLFW3

class Tests: XCTestCase {

    func testInit() throws {
        XCTAssertEqual(glfwInit(), GLFW_TRUE)
        
        glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 4)
        glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 1)
        
        glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE)
        glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GLFW_TRUE)
        
        XCTAssertEqual(glfwGetError(nil), GLFW_NO_ERROR)
        
        let window = glfwCreateWindow(400, 300, "CGLFW3 Testing", nil, nil)
        XCTAssertEqual(glfwGetError(nil), GLFW_NO_ERROR)
        XCTAssertNotNil(window)
        
        glfwMakeContextCurrent(window)
        XCTAssertEqual(glfwGetError(nil), GLFW_NO_ERROR)
        
        XCTAssertNotNil(window)
        glfwPollEvents()
        glfwSwapBuffers(window)
        
        XCTAssertEqual(glfwGetError(nil), GLFW_NO_ERROR)
        glfwTerminate()
    }

    func testBufferSwapPerformance() throws {
        XCTAssertEqual(glfwInit(), GLFW_TRUE)
        
        glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 4)
        glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 1)
        
        glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE)
        glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GLFW_TRUE)
        
        XCTAssertEqual(glfwGetError(nil), GLFW_NO_ERROR)
        
        let window = glfwCreateWindow(400, 300, "CGLFW3 Testing", nil, nil)
        XCTAssertEqual(glfwGetError(nil), GLFW_NO_ERROR)
        XCTAssertNotNil(window)
        
        glfwMakeContextCurrent(window)
        XCTAssertEqual(glfwGetError(nil), GLFW_NO_ERROR)
        
        glfwSwapInterval(0)
        
        glfwSwapBuffers(window)
        glfwPollEvents()
        
        var frames = 0
        self.measure {
            while frames < 600 {
                glfwSwapBuffers(window)
                glfwPollEvents()
                frames += 1
            }
        }
        
        glfwTerminate()
    }

}
