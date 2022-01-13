import UIKit

//MARK: Initialization
///Initialization is the process of preparing an instance of a class, structure, or enumeration for use. This process involves setting an initial value for each stored property on that instance and performing any other setup or initialization that’s  required before the new instance is ready for use. Swift initializers don’t return a value. Their primary role is to ensure that new instances of a type are correctly initialized before they’re used for the first time.
struct Fahrenheit {
    var temperature: Double
    init() {
        temperature = 32.0
    }
}
var f = Fahrenheit()
print("The default temperature is \(f.temperature)° Fahrenheit")
/// Prints "The default temperature is 32.0° Fahrenheit"

//MARK: Initialization Parameters
struct Celsius {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
}
let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
/// boilingPointOfWater.temperatureInCelsius is 100.0
let freezingPointOfWater = Celsius(fromKelvin: 273.15)
/// freezingPointOfWater.temperatureInCelsius is 0.0

//MARK: Parameter Names and Argument Labels
///As with function and method parameters, initialization parameters can have both a parameter name for use within the initializer’s body and an argument label for use when calling the initializer.
struct Color {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red   = red
        self.green = green
        self.blue  = blue
    }
    init(white: Double) {
        red   = white
        green = white
        blue  = white
    }
}

//MARK: Optional Property Types
class SurveyQuestion {
    var text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}
let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
cheeseQuestion.ask()
/// Prints "Do you like cheese?"
cheeseQuestion.response = "Yes, I do like cheese."
///The response to a survey question can’t be known until it’s asked, and so the response property is declared with a type of String?, or “optional String”. It’s automatically assigned a default value of nil, meaning “no string yet”, when a new instance of SurveyQuestion is initialized.

//MARK: Assigning Constant Properties During Initialization
///Once a constant property is assigned a value, it can’t be further modified.

//MARK: Default Initializers
///We are using default initializers, when all properties are already initialized in the Class, Struct and etc. or it's a base class with no superclass
class ShoppingListItem {
    var name: String?
    var quantity = 1
    var purchased = false
}
var item = ShoppingListItem()

//MARK: Memberwise Initializers for Structure Types
///The Size structure automatically receives an init(width:height:) memberwise initializer, which we can use to initialize a new Size instance:
///For value types, we use self.init to refer to other initializers from the same value type when writing our own custom initializers. We can call self.init only from within an initializer.

struct Size {
    var width = 0.0, height = 0.0
}
let twoByTwo = Size(width: 2.0, height: 2.0)
///When we call a memberwise initializer, we can omit values for any properties that have default values.
let zeroByTwo = Size(height: 2.0)
print(zeroByTwo.width, zeroByTwo.height)
/// Prints "0.0 2.0"
let zeroByZero = Size()
print(zeroByZero.width, zeroByZero.height)
/// Prints "0.0 0.0"

//MARK: Initializer Delegation for Value Types
struct _Size {
    var width = 0.0, height = 0.0
}
struct _Point {
    var x = 0.0, y = 0.0
}

///We can initialize the Rect structure below in one of three ways—by using its default zero-initialized origin and size property values, by providing a specific origin point and size, or by providing a specific center point and size. These initialization options are represented by three custom initializers that are part of the Rect structure’s definition:
struct Rect {
    var origin = _Point()
    var size = _Size()
    init() {}
    init(origin: _Point, size: _Size) {
        self.origin = origin
        self.size = size
    }
    init(center: _Point, size: _Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: _Point(x: originX, y: originY), size: size)
    }
}
///The first Rect initializer, init(), is functionally the same as the default initializer that the structure would have received if it didn’t have its own custom initializers. This initializer has an empty body, represented by an empty pair of curly braces {}. Calling this initializer returns a Rect instance whose origin and size properties are both initialized with the default values of Point(x: 0.0, y: 0.0) and Size(width: 0.0, height: 0.0) from their property definitions:
///For value types, we use self.init to refer to other initializers from the same value type when writing our own custom initializers. We can call self.init only from within an initializer.
let basicRect = Rect()
/// basicRect's origin is (0.0, 0.0) and its size is (0.0, 0.0)

//MARK: Class Inheritance and Initialization
///All of a class’s stored properties—including any properties the class inherits from its superclass—must be assigned an initial value during initialization.

//MARK: Designated Initializers and Convenience Initializers
///Designated initializers ensure that the object is ready to be used and all of its properties are initialized
///Convinience intializers are for us to pre-set some of the properties of the object based on what we need and this initializer should call designated init, just to make sure, that all of its porperties are set
struct Grade {
  let letter: String
  let points: Double
  let credits: Double
}

class _Student {
  let firstName: String
  let lastName: String
  var grades: [Grade] = []
  init(firstName: String, lastName: String) {
    self.firstName = firstName
    self.lastName = lastName
  }
  init(transfer: Student) {
    self.firstName = transfer.firstName
    self.lastName = transfer.lastName
  }
  func recordGrade(_ grade: Grade) {
    grades.append(grade)
  }
}

//MARK: If we decide the first and last name-based initializer is important enough that we want it to be         available to all subclasses. Swift supports this through the language feature known as required          initializers.
class Student {
  let firstName: String
  let lastName: String
  var grades: [Grade] = []
  required init(firstName: String, lastName: String) {
    self.firstName = firstName
    self.lastName = lastName
  }
  /// original code
}
///We must also write the required modifier before every subclass implementation of a required initializer, to indicate that the initializer requirement applies to further subclasses in the chain. We don’t write the override modifier when overriding a required designated initializer:

///For example: Now that there’s a required initializer on Student, StudentAthlete must override and implement it.
class StudentAthlete: Student {
  // Now required by the compiler!
  required init(firstName: String, lastName: String) {
//    self.sports = []
    super.init(firstName: firstName, lastName: lastName)
  }
    // original code
}
///The compiler forces a convenience initializer to call a non-convenience initializer (directly or indirectly) instead of handling the initialization of stored properties itself. A non-convenience initializer is called a designated initializer and is subject to the rules of two-phase initialization. All initializers we’ve written in previous examples were, in fact, designated initializers.


//MARK: Initializer Delegation for Class Types
///To simplify the relationships between designated and convenience initializers, Swift applies the following three rules for delegation calls between initializers:
/// * Rule 1
///   A designated initializer must call a designated initializer from its immediate superclass.
/// * Rule 2
///   A convenience initializer must call another initializer from the same class.
/// * Rule 3
///   A convenience initializer must ultimately call a designated initializer.
/// There is an illustration in the Swift's Documentation

//  So in the Superclass, convenience init depends on the designated init. and in Subclass, designated init depends on Superclass's designated init, and subclass's convenience init depends on designated init.

//MARK: Two-Phase Initialization
/// Swift’s requirement is that all stored properties have initial values, initializers in subclasses must adhere to Swift’s convention of two-phase initialization
/// • Phase one: Initialize all of the stored properties in the class instance, from the bottom to the top of the class hierarchy. We can’t use properties and methods until phase one is complete.
/// • Phase two: We can now use properties, methods and initializations that require the use of self.
/// Without two-phase initialization, methods and operations on the class might interact with properties before they’ve been initialized.
/// The transition from phase one to phase two happens after we've initialized all stored properties in the base(highest) class of a class hierarchy.

/// Call super.init. When we know that we've also initialized every class in the hierarchy because the same rules apply at every level.


//MARK: Failable Initializers
///It’s sometimes useful to define a class, structure, or enumeration for which initialization can fail. This failure might be triggered by invalid initialization parameter values, the absence of a required external resource, or some other condition that prevents initialization from succeeding.  We write a failable initializer by placing a question mark after the init keyword (init?).

///Failable initalizers means that if initialization fails, it will return nil instead of full intialization.
struct User {
    let userName : String
    let password : String
    
    init?(userName: String, candidatePassword: String) {
        guard candidatePassword.count > 5 else { return nil }
        guard !candidatePassword.contains("12345") else { return nil }
        self.userName = userName
        self.password = candidatePassword
    }
}

let user = User(userName: "ilia", candidatePassword: "tsik")
///We write return nil within a failable initializer to indicate a point at which initialization failure can be triggered.
///Strictly speaking, initializers don’t return a value. Rather, their role is to ensure that self is fully and correctly initialized by the time that initialization ends. Although we write return nil to trigger an initialization failure, we don’t use the return keyword to indicate initialization success.

//MARK: Failable Initializers for Enumerations
///We can use a failable initializer to select an appropriate enumeration case based on one or more parameters. The initializer can then fail if the provided parameters don’t match an appropriate enumeration case.
enum TemperatureUnit {
    case kelvin, celsius, fahrenheit
    init?(symbol: Character) {
        switch symbol {
        case "K":
            self = .kelvin
        case "C":
            self = .celsius
        case "F":
            self = .fahrenheit
        default:
            return nil
        }
    }
}

let fahrenheitUnit = TemperatureUnit(symbol: "F")
if fahrenheitUnit != nil {
    print("This is a defined temperature unit, so initialization succeeded.")
}
/// Prints "This is a defined temperature unit, so initialization succeeded."

let unknownUnit = TemperatureUnit(symbol: "X")
if unknownUnit == nil {
    print("This isn't a defined temperature unit, so initialization failed.")
}
/// Prints "This isn't a defined temperature unit, so initialization failed."

//MARK: Overriding a Failable Initializer
///We can override a superclass failable initializer in a subclass, just like any other initializer. Alternatively, we can override a superclass failable initializer with a subclass nonfailable initializer. This enables us to define a subclass for which initialization can’t fail, even though initialization of the superclass is allowed to fail.
class Document {
    var name: String?
    /// this initializer creates a document with a nil name value
    init() {}
    /// this initializer creates a document with a nonempty name value
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}

class AutomaticallyNamedDocument: Document {
    override init() {
        super.init()
        self.name = "[Untitled]"
    }
    override init(name: String) {
        super.init()
        if name.isEmpty {
            self.name = "[Untitled]"
        } else {
            self.name = name
        }
    }
}
