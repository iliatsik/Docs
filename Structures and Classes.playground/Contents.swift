import UIKit

//Structures and Classes

//Comparing Structures and Classes

/// Common:
/// - Define properties to store values
/// - Define methods to provide functionality
/// - Define subscripts to provide access to their values using subscript syntax
/// - Define initializers to set up their initial state
/// - Be extended to expand their functionality beyond a default implementation
/// - Conform to protocols to provide standard functionality of a certain kind

/// Classes have additional capabilities that structures don’t have:
/// - Inheritance enables one class to inherit the characteristics of another.
/// - Type casting enables you to check and interpret the type of a class instance at runtime.
/// - Deinitializers enable an instance of a class to free up any resources it has assigned.
/// - Reference counting allows more than one reference to a class instance.

struct Resolution {
    var width = 0
    var height = 0
}
class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

//Memberwise Initializers for Structure Types
let vga = Resolution(width: 640, height: 480)
///Unlike structures, class instances don’t receive a default memberwise initializer

//Structures and Enumerations Are Value Types
let hd = Resolution(width: 1920, height: 1080)
var cinema = hd
///Even though hd and cinema now have the same width and height, they’re two completely different instances behind the scenes.

//Classes Are Reference Types
let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0

let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0
///Because classes are reference types, tenEighty and alsoTenEighty actually both refer to the same VideoMode instance. Effectively, they’re just two different names for the same single instance, as shown in the figure below:
print("The frameRate property of tenEighty is now \(tenEighty.frameRate)")
/// Prints "The frameRate property of tenEighty is now 30.0"

//Identity Operators
/// It can sometimes be useful to find out whether two constants or variables refer to exactly the same instance of a class. To enable this, Swift provides two identity operators:
/// - Identical to (===)
/// - Not identical to (!==)

if tenEighty === alsoTenEighty {
    print("tenEighty and alsoTenEighty refer to the same VideoMode instance.")
}
/// Prints "tenEighty and alsoTenEighty refer to the same VideoMode instance."

