import UIKit

//MARK: Subscripts
/// We use shortcuts for accessing the member elements of a collection, list, or sequence. We use subscripts to set and retrieve values by index without needing separate methods for setting and retrieval. For example, we access elements in an Array instance as someArray[index]

//MARK: Subscript Syntax
///Subscripts enables to query instances of a type by writing one or more values in square brackets after the instance name. Their syntax is similar to both instance method syntax and computed property syntax.
struct SomeStruct {
    subscript(index: Int) -> Int {
        get {
            /// Return an appropriate subscript value here.
            return 0
        }
        set(newValue) {
            /// Perform a suitable setting action here.
        }
    }
}

///Here’s an example of a read-only subscript implementation, which defines a TimesTable structure to represent an n-times-table of integers:
struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}
let threeTimesTable = TimesTable(multiplier: 3)
print("six times three is \(threeTimesTable[6])")
/// Prints "six times three is 18"

//MARK: Subscript Options
///Subscripts can take any number of input parameters, and these input parameters can be of any type. Subscripts can also return a value of any type.
///Subscripts can’t use in-out parameters.

//MARK: Type Subscripts
///Instance subscripts, as described above, are subscripts that we call on an instance of a particular type. We can also define subscripts that are called on the type itself. This kind of subscript is called a type subscript. We indicate a type subscript by writing the static keyword before the subscript keyword. Classes can use the class keyword instead, to allow subclasses to override the superclass’s implementation of that subscript.
enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
    static subscript(n: Int) -> Planet {
        return Planet(rawValue: n)!
    }
}
let mars = Planet[4]
print(mars)
