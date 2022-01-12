import UIKit

//Properties

//MARK: Stored Properties
///In its simplest form, a stored property is a constant or variable that’s stored as part of an instance of a particular class or structure. Stored properties can be either variable stored properties (introduced by the var keyword) or constant stored properties (introduced by the let keyword).

struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}
var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
/// the range represents integer values 0, 1, and 2
rangeOfThreeItems.firstValue = 6
/// the range now represents integer values 6, 7, and 8
/// Instances of FixedLengthRange have a variable stored property called firstValue and a constant stored property called length.

//MARK: Stored Properties of Constant Structure Instances
///If we create an instance of a structure and assign that instance to a constant, we can’t modify the instance’s properties, even if they were declared as variable properties:

let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
/// this range represents integer values 0, 1, 2, and 3
//  rangeOfFourItems.firstValue = 6
/// this will report an error, even though firstValue is a variable property

///This behavior is due to structures being value types. When an instance of a value type is marked as a constant, so are all of its properties.

///The same isn’t true for classes, which are reference types. If we assign an instance of a reference type to a constant, we
/// can still change that instance’s variable properties.


//MARK: Lazy Stored Properties

///lazy stored property is property whose initial value isn’t calculated until the first time it’s used.We indicate lazy stored property by writing the lazy modifier before its declaration.
///It should always be var.
///Lazy properties are useful when the initial value for a property is dependent on outside factors whose values aren’t known until after an instance’s initialization is complete. Lazy properties are also useful when the initial value for a property requires complex or computationally expensive setup that shouldn’t be performed unless or until it’s needed.

///The example below uses a lazy stored property to avoid unnecessary initialization of a complex class. This example defines two classes called DataImporter and DataManager, neither of which is shown in full:
class DataImporter {
    /*
    DataImporter is a class to import data from an external file.
    The class is assumed to take a nontrivial amount of time to initialize.
    */
    var filename = "data.txt"
    /// the DataImporter class would provide data importing functionality here
}

class DataManager {
    lazy var importer = DataImporter()
    var data: [String] = []
    /// the DataManager class would provide data management functionality here
}

let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Some more data")
/// the DataImporter instance for the importer property hasn't yet been created

///Because it’s marked with the lazy modifier, the DataImporter instance for the importer property is only created when the importer property is first accessed, such as when its filename property is queried:

print(manager.importer.filename)
/// the DataImporter instance for the importer property has now been created
/// Prints "data.txt"


//MARK: Computed Properties   //set and get
///In addition to stored properties, classes, structures, and enumerations can define computed properties, which don’t actually store a value. Instead, they provide a getter and an optional setter to retrieve and set other properties and values indirectly.
struct Point {
    var x = 0.0, y = 0.0
}
struct Size {
    var width = 0.0, height = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {   /// We can omit property declarations and return keyword and instead of it we can use just Point(x: someValue, y: someValue)
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) { /// Orr we can omit newCenter and use its shorthand version, as a default newValue
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
}
var square = Rect(origin: Point(x: 0.0, y: 0.0),
                  size: Size(width: 10.0, height: 10.0))
let initialSquareCenter = square.center
square.center = Point(x: 15.0, y: 15.0)
print("square.origin is now at (\(square.origin.x), \(square.origin.y))")
/// Prints "square.origin is now at (10.0, 10.0)"


//MARK: Read-Only Computed Properties //without set and get just to return the value within the property
struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
}
let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
print("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")
/// Prints "the volume of fourByFiveByTwo is 40.0"
/// It doesn’t make sense for volume to be settable, because it would be ambiguous as to which values of width, height, and depth should be used for a particular volume value. Nonetheless, it’s useful for a Cuboid to provide a read-only computed property to enable external users to discover its current calculated volume.


//MARK: Property Observers
///Property observers observe and respond to changes in a property’s value. Property observers are called every time a property’s value is set, even if the new value is the same as the property’s current value.
/// We can add property observers in the following places:
/// * Stored properties that we define
/// * Stored properties that we inherit
/// * Computed properties that we inherit

///For an inherited property, we add a property observer by overriding that property in a subclass. For a computed property that we define, use the property’s setter to observe and respond to value changes, instead of trying to create an observer.

/// We have the option to define either or both of these observers on a property:
/// * willSet is called just before the value is stored.
/// * didSet is called immediately after the new value is stored.

class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("About to set totalSteps to \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue  {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}
let stepCounter = StepCounter()
stepCounter.totalSteps = 200
/// About to set totalSteps to 200
/// Added 200 steps
stepCounter.totalSteps = 360
/// About to set totalSteps to 360
/// Added 160 steps
stepCounter.totalSteps = 896
/// About to set totalSteps to 896
/// Added 536 steps

/// - The willSet and didSet observers for totalSteps are called whenever the property is assigned a new value. This is true even if the new value is the same as the current value.
/// - This example’s willSet observer uses a custom parameter name of newTotalSteps for the upcoming new value. In this example, it simply prints out the value that’s about to be set.
/// - The didSet observer is called after the value of totalSteps is updated. It compares the new value of totalSteps against the old value.


//MARK: Property Wrappers
///A property wrapper adds a layer of separation between code that manages how a property is stored and the code that defines a property. For example, if we have properties that provide thread-safety checks or store their underlying data in a database, we have to write that code on every property. When we use a property wrapper, we write the management code once when we define the wrapper, and then reuse that management code by applying it to multiple properties.

///To define a property wrapper, we make a structure, enumeration, or class that defines a wrappedValue property. In the code below, the TwelveOrLess structure ensures that the value it wraps always contains a number less than or equal to 12. If we ask it to store a larger number, it stores 12 instead.

@propertyWrapper
struct TwelveOrLess {
    private var number = 0
    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, 12) }
    }
}
///The setter ensures that new values are less than 12, and the getter returns the stored value.

///We apply a wrapper to a property by writing the wrapper’s name before the property as an attribute. Here’s a structure that stores a rectangle that uses the TwelveOrLess property wrapper to ensure its dimensions are always 12 or less:
struct SmallRectangle {
    @TwelveOrLess var height: Int
    @TwelveOrLess var width: Int
}

var rectangle = SmallRectangle()
print(rectangle.height)
/// Prints "0"

rectangle.height = 10
print(rectangle.height)
/// Prints "10"

rectangle.height = 24
print(rectangle.height)
/// Prints "12"

///It's a version of SmallRectangle from the previous code listing that wraps its properties in the TwelveOrLess structure explicitly, instead of writing @TwelveOrLess as an attribute:

struct _SmallRectangle {
    private var _height = TwelveOrLess()
    private var _width = TwelveOrLess()
    var height: Int {
        get { return _height.wrappedValue }
        set { _height.wrappedValue = newValue }
    }
    var width: Int {
        get { return _width.wrappedValue }
        set { _width.wrappedValue = newValue }
    }
}

///Here’s an expanded version of TwelveOrLess called SmallNumber that defines initializers that set the wrapped and maximum value:

@propertyWrapper
struct SmallNumber {
    private var maximum: Int
    private var number: Int

    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, maximum) }
    }

    init() {
        maximum = 12
        number = 0
    }
    init(wrappedValue: Int) {
        maximum = 12
        number = min(wrappedValue, maximum)
    }
    init(wrappedValue: Int, maximum: Int) {
        self.maximum = maximum
        number = min(wrappedValue, maximum)
    }
}

///When we apply a wrapper to a property and we don’t specify an initial value, Swift uses the init() initializer to set up the wrapper. For example:

struct ZeroRectangle {
    @SmallNumber var height: Int
    @SmallNumber var width: Int
}

var zeroRectangle = ZeroRectangle()
print(zeroRectangle.height, zeroRectangle.width)
/// Prints "0 0"

///This syntax is the most general way to use a property wrapper
///When we include property wrapper arguments, we can also specify an initial value using assignment. Swift treats the assignment like a wrappedValue argument and uses the initializer that accepts the arguments we include. For example:

struct MixedRectangle {
    @SmallNumber var height: Int = 1
    @SmallNumber(maximum: 9) var width: Int = 2
}

var mixedRectangle = MixedRectangle()
print(mixedRectangle.height)
/// Prints "1"

mixedRectangle.height = 20
print(mixedRectangle.height)
/// Prints "12"

//MARK: Projecting a Value From a Property Wrapper
/// The name of the projected value is the same as the wrapped value, except it begins with a dollar sign ($). Because our code can’t define properties that start with $ the projected value never interferes with properties we define.
///In the SmallNumber example above, if we try to set the property to a number that’s too large, the property wrapper adjusts the number before storing it. The code below adds a projectedValue property to the SmallNumber structure to keep track of whether the property wrapper adjusted the new value for the property before storing that new value.

@propertyWrapper
struct _SmallNumber {
    private var number: Int
    private(set) var projectedValue: Bool

    var wrappedValue: Int {
        get { return number }
        set {
            if newValue > 12 {
                number = 12
                projectedValue = true
            } else {
                number = newValue
                projectedValue = false
            }
        }
    }

    init() {
        self.number = 0
        self.projectedValue = false
    }
}
struct SomeStructure {
    @_SmallNumber var someNumber: Int
}
var someStructure = SomeStructure()

someStructure.someNumber = 4
print(someStructure.$someNumber)
/// Prints "false"

someStructure.someNumber = 55
print(someStructure.$someNumber)
/// Prints "true"
///A property wrapper can return a value of any type as its projected value. In this example, the property wrapper exposes only one piece of information—whether the number was adjusted—so it exposes that Boolean value as its projected value. A wrapper that needs to expose more information can return an instance of some other data type, or it can return self to expose the instance of the wrapper as its projected value.


//MARK: Global and Local Variables
///Global constants and variables are always computed lazily, in a similar manner to Lazy Stored Properties. Unlike lazy stored properties, global constants and variables don’t need to be marked with the lazy modifier. Local constants and variables are never computed lazily.
///You can apply a property wrapper to a local stored variable, but not to a global variable or a computed variable. For example, in the code below, myNumber uses SmallNumber as a property wrapper.

func someFunction() {
    @SmallNumber var myNumber: Int = 0
    myNumber = 10
    /// now myNumber is 10
    myNumber = 24
    /// now myNumber is 12
}
///Like when you apply SmallNumber to a property, setting the value of myNumber to 10 is valid. Because the property wrapper doesn’t allow values higher than 12, it sets myNumber to 12 instead of 24.


//MARK: Type Property
///Stored type properties are lazily initialized on their first access. They’re guaranteed to be initialized only once, even when accessed by multiple threads simultaneously, and they don’t need to be marked with the lazy modifier.
struct _SomeStructure {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 1
    }
}
enum SomeEnumeration {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 6
    }
}
class SomeClass {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 27
    }
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}
///We define type properties with the static keyword. For computed type properties for class types, we can use the class keyword instead to allow subclasses to override the superclass’s implementation. 
