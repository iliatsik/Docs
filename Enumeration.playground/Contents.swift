import UIKit

//Enumerations

///An enumeration defines a common type for a group of related values and enables us to work with those values in a type-safe way within your code.
enum CompassPoint {
    case north
    case south
    case east
    case west
}

///Multiple cases can appear on a single line, separated by commas:
enum Planets {
    case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune
}
///Each enumeration definition defines a new type. Like other types in Swift, their names (such as CompassPoint and Planet) start with a capital letter.


//Matching Enumeration Values with a Switch Statement
var directionToHead = CompassPoint.west
directionToHead = .south

switch directionToHead {
case .north:
    print("Lots of planets have a north")
case .south:
    print("Watch out for penguins")
case .east:
    print("Where the sun rises")
case .west:
    print("Where the skies are blue")
}
/// Prints "Watch out for penguins"


//Iterating over Enumeration Cases

///If we want to have a collection of all of that enumeration’s cases. we enable this by writing : CaseIterable after the enumeration’s name. Swift exposes a collection of all the cases as an allCases property of the enumeration type.
enum Beverage: CaseIterable {
    case coffee, tea, juice
}

let numberOfChoices = Beverage.allCases.count
print("\(numberOfChoices) beverages available")
/// Prints "3 beverages available"

/// We can use allCases like any other collection—the collection’s elements are instances of the enumeration type
for beverage in Beverage.allCases {
    print(beverage)
}
/// coffee, tea, juice


//Associated Values
///it’s sometimes useful to be able to store values of other types alongside these case values. This additional information is called an associated value, and it varies each time we use that case as a value in our code.
enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}
///“Define an enumeration type called Barcode, which can take either a value of upc with an associated value of type (Int, Int, Int, Int), or a value of qrCode with an associated value of type String.”
var productBarcode = Barcode.upc(8, 85909, 51226, 3)


//Raw Values
///Raw values can be strings, characters, or any of the integer or floating-point number types. Each raw value must be unique within its enumeration declaration.

enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}

//Implicitly Assigned Raw Values
enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}
/// In this point, if mercury is 1, then  Planet.venus has an implicit raw value of 2, and so on.

///When strings are used for raw values, the implicit value for each case is the text of that case’s name.
///We access the raw value of an enumeration case with its rawValue property:
let earthsOrder = Planet.earth.rawValue
/// earthsOrder is 3

//Initializing from a Raw Value
///If we define an enumeration with a raw-value type, the enumeration automatically receives an initializer that takes a value of the raw value’s type (as a parameter called rawValue) and returns either an enumeration case or nil. We can use this initializer to try to create a new instance of the enumeration.
let possiblePlanet = Planet(rawValue: 7)
/// possiblePlanet is of type Planet? and equals Planet.uranus

///If we try to find a planet with a position of 11, the optional Planet value returned by the raw value initializer will be nil:
let positionToFind = 11
if let somePlanet = Planet(rawValue: positionToFind) {
    switch somePlanet {
    case .earth:
        print("Mostly harmless")
    default:
        print("Not a safe place for humans")
    }
} else {
    print("There isn't a planet at position \(positionToFind)")
}
/// Prints "There isn't a planet at position 11"


//Recursive Enumerations
///A recursive enumeration is an enumeration that has another instance of the enumeration as the associated value for one or more of the enumeration cases. We indicate that an enumeration case is recursive by writing indirect before it, which tells the compiler to insert the necessary layer of indirection.
enum ArithmeticExpression0 {
    case number(Int)
    indirect case addition(ArithmeticExpression0, ArithmeticExpression0)
    indirect case multiplication(ArithmeticExpression0, ArithmeticExpression0)
}

///We can also write indirect before the beginning of the enumeration to enable indirection for all of the enumeration’s cases that have an associated value:
indirect enum ArithmeticExpression {
    case number(Int)
    case addition(ArithmeticExpression, ArithmeticExpression)
    case multiplication(ArithmeticExpression, ArithmeticExpression)
}

let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))

///A recursive function is a straightforward way to work with data that has a recursive structure. For example, here’s a function that evaluates an arithmetic expression:
func evaluate(_ expression: ArithmeticExpression) -> Int {
    switch expression {
    case let .number(value):
        return value
    case let .addition(left, right):
        return evaluate(left) + evaluate(right)
    case let .multiplication(left, right):
        return evaluate(left) * evaluate(right)
    }
}
print(evaluate(product)) /// Prints "18"
