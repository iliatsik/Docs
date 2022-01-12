import UIKit

//MARK: Methods

///Methods are functions that are associated with a particular type. Classes, structures, and enumerations can all define instance methods, which encapsulate specific tasks and functionality for working with an instance of a given type. Classes, structures, and enumerations can also define type methods, which are associated with the type itself.

//MARK: Instance Methods
///Instance methods are functions that belong to instances of a particular class, structure, or enumeration. They support the functionality of those instances
///We write an instance method within the opening and closing braces of the type it belongs to. An instance method has implicit access to all other instance methods and properties of that type.
class Counter {
    var count = 0
    func increment() {
        count += 1
    }
    func increment(by amount: Int) {
        count += amount
    }
    func reset() {
        count = 0
    }
}
///The Counter class defines three instance methods:
/// - increment() increments the counter by 1.
/// - increment(by: Int) increments the counter by a specified integer amount.
/// - reset() resets the counter to zero.
let counter = Counter()
/// the initial counter value is 0
counter.increment()
/// the counter's value is now 1
counter.increment(by: 5)
/// the counter's value is now 6
counter.reset()
/// the counter's value is now 0

//MARK: The self Property
///Every instance of a type has an implicit property called self, which is exactly equivalent to the instance itself. We use the self property to refer to the current instance within its own instance methods.
class _Counter {
    var count = 0
    func increment() {
        self.count += 1
    }
}
///The main exception to this rule occurs when a parameter name for an instance method has the same name as a property of that instance. In this situation, the parameter name takes precedence, and it becomes necessary to refer to the property in a more qualified way. We use the self property to distinguish between the parameter name and the property name.
struct Point {
    var x = 0.0, y = 0.0
    func isToTheRightOf(x: Double) -> Bool {
        return self.x > x
    }
}
let somePoint = Point(x: 4.0, y: 5.0)
if somePoint.isToTheRightOf(x: 1.0) {
    print("This point is to the right of the line where x == 1.0")
}
/// Prints "This point is to the right of the line where x == 1.0"
/// Without the self prefix, Swift would assume that both uses of x referred to the method parameter called x.

//MARK: Modifying Value Types from Within Instance Methods
///if we need to modify the properties of our structure or enumeration within a particular method, we can opt in to mutating behavior for that method.
struct _Point {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}
var _somePoint = _Point(x: 1.0, y: 1.0)
_somePoint.moveBy(x: 2.0, y: 3.0)
print("The point is now at (\(_somePoint.x), \(_somePoint.y))")
/// Prints "The point is now at (3.0, 4.0)"

///We can’t call a mutating method on a constant of structure type, because its properties can’t be changed, even if they’re variable properties
let fixedPoint = Point(x: 3.0, y: 3.0)
//fixedPoint.moveBy(x: 2.0, y: 3.0)
/// this will report an error

//MARK: Assigning to self Within a Mutating Method
///Mutating methods can assign an entirely new instance to the implicit self property.
struct Point0 {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        self = Point0(x: x + deltaX, y: y + deltaY)
    }
}

///Mutating methods for enumerations can set the implicit self parameter to be a different case from the same enumeration:
enum TriStateSwitch {
    case off, low, high
    mutating func next() {
        switch self {
        case .off:
            self = .low
        case .low:
            self = .high
        case .high:
            self = .off
        }
    }
}
var ovenLight = TriStateSwitch.low
ovenLight.next()
/// ovenLight is now equal to .high
ovenLight.next()
/// ovenLight is now equal to .off


//MARK: Type Methods
///We can also define methods that are called on the type itself. These kinds of methods are called type methods. We indicate type methods by writing the static keyword before the method’s func keyword. Classes can use the class keyword instead, to allow subclasses to override the superclass’s implementation of that method.
/// We' call type methods on the type, not on an instance of that type
class SomeClass {
    class func someTypeMethod() {
        /// type method implementation goes here
    }
}
SomeClass.someTypeMethod()


///All of the game’s levels (apart from level one) are locked when the game is first played. Every time a player finishes a level, that level is unlocked for all players on the device. The LevelTracker structure uses type properties and methods to keep track of which levels of the game have been unlocked. It also tracks the current level for an individual player.
struct LevelTracker {
    static var highestUnlockedLevel = 1
    var currentLevel = 1

    static func unlock(_ level: Int) {
        if level > highestUnlockedLevel { highestUnlockedLevel = level }
    }

    static func isUnlocked(_ level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }

    @discardableResult
    mutating func advance(to level: Int) -> Bool {
        if LevelTracker.isUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}


class Player {
    var tracker = LevelTracker()
    let playerName: String
    func complete(level: Int) {
        LevelTracker.unlock(level + 1)
        tracker.advance(to: level + 1)
    }
    init(name: String) {
        playerName = name
    }
}


var player = Player(name: "Argyrios")
player.complete(level: 1)
print("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")
/// Prints "highest unlocked level is now 2"

///If you create a second player, whom you try to move to a level that’s not yet unlocked by any player in the game, the attempt to set the player’s current level fails:
player = Player(name: "Beto")
if player.tracker.advance(to: 6) {
    print("player is now on level 6")
} else {
    print("level 6 hasn't yet been unlocked")
}
/// Prints "level 6 hasn't yet been unlocked"
