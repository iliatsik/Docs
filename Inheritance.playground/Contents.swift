import UIKit

//MARK: Inheritance
///A class can inherit methods, properties, and other characteristics from another class. When one class inherits from another, the inheriting class is known as a subclass, and the class it inherits from is known as its superclass. Inheritance is a fundamental behavior that differentiates classes from other types in Swift.

//MARK: Defining a Base Class
class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    func makeNoise() {
        /// do nothing - an arbitrary vehicle doesn't necessarily make a noise
    }
}
let someVehicle = Vehicle()
print("Vehicle: \(someVehicle.description)")
/// Vehicle: traveling at 0.0 miles per hour


//MARK: Subclassing
///Subclassing is the act of basing a new class on an existing class. The subclass inherits characteristics from the existing class, which we can then refine. We can also add new characteristics to the subclass.
class Bicycle: Vehicle {
    var hasBasket = false
}
let bicycle = Bicycle()
bicycle.hasBasket = true
bicycle.currentSpeed = 15.0
print("Bicycle: \(bicycle.description)")
/// Bicycle: traveling at 15.0 miles per hour

///Subclasses can themselves be subclassed.
class Tandem: Bicycle {
    var currentNumberOfPassengers = 0
}
let tandem = Tandem()
tandem.hasBasket = true
tandem.currentNumberOfPassengers = 2
tandem.currentSpeed = 22.0
print("Tandem: \(tandem.description)")
// Tandem: traveling at 22.0 miles per hour

//MARK: Overhiding
///To override a characteristic that would otherwise be inherited, prefix will be overriding definition with the override keyword. Doing so clarifies that you intend to provide an override and haven’t provided a matching definition by mistake. Overriding by accident can cause unexpected behavior, and any overrides without the override keyword are diagnosed as an error when your code is compiled.

///The override keyword also prompts the Swift compiler to check that your overriding class’s superclass (or one of its parents) has a declaration that matches the one you provided for the override. This check ensures that your overriding definition is correct.

//Accessing Superclass Methods, Properties, and Subscripts
///When we provide a method, property, or subscript override for a subclass, it’s sometimes useful to use the existing superclass implementation as part of your override. For example, we can refine the behavior of that existing implementation, or store a modified value in an existing inherited variable.

//MARK: Overriding Methods
class Train: Vehicle {
    override func makeNoise() {
        print("Choo Choo")
    }
}
///if we create a new instance of Train and call its makeNoise() method, we can see that the Train subclass version of the method is called:
let train = Train()
train.makeNoise()
/// Prints "Choo Choo"

//MARK: Overriding Properties (getters and setters)
///The Car class introduces a new stored property called gear, with a default integer value of 1. The Car class also overrides the description property it inherits from Vehicle, to provide a custom description that includes the current gear
class Car: Vehicle {
    var gear = 1
    override var description: String {
        return super.description + " in gear \(gear)"
    }
}
///The override of the description property starts by calling super.description, which returns the Vehicle class’s description property. The Car class’s version of description then adds some extra text onto the end of this description to provide information about the current gear.
let car = Car()
car.currentSpeed = 25.0
car.gear = 3
print("Car: \(car.description)")
/// Car: traveling at 25.0 miles per hour in gear 3

//MARK: Overriding Property Observers
///The value of these properties can’t be set, and so it isn’t appropriate to provide a willSet or didSet implementation as part of an override.
class AutomaticCar: Car {
    override var currentSpeed: Double {
        didSet {
            gear = Int(currentSpeed / 10.0) + 1
        }
    }
}
let automatic = AutomaticCar()
automatic.currentSpeed = 35.0
print("AutomaticCar: \(automatic.description)")
/// AutomaticCar: traveling at 35.0 miles per hour in gear 4

//MARK: Preventing Overrides
///We can prevent a method, property, or subscript from being overridden by marking it as final. Do this by writing the final modifier before the method, property, or subscript’s introducer keyword (such as final var, final func, final class func, and final subscript).


