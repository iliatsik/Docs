import UIKit

//MARK: Optional Chaining
///Sometimes force unwrapping or using an implicitly unwrapped optional is just fine. If we have @IBOutlets in our UIKit app, we know those elements must exist after the view loads, and if they don’t, there is something wrong with our app. In general, force unwrap or using implicitly unwrapped optionals is appropriate only when an optional must contain a value. In all other cases, we’re asking for trouble!
/// process for querying and calling properties, methods, and subscripts on an optional that might currently be nil
class Person {
    var residence: Residence?
    var name : String?
}

class Residence {
    var numberOfRooms = 1
}

///If we create a new Person instance, its residence property is default initialized to nil, by virtue of being optional. In the code below, john has a residence property value of nil:
let john = Person()
///If we try to access the numberOfRooms property of this person’s residence, by placing an exclamation point after residence to force the unwrapping of its value, we trigger a runtime error, because there’s no residence value to unwrap:

let roomCount = john.residence!.numberOfRooms
/// this triggers a runtime error

///Optional chaining provides an alternative way to access the value of numberOfRooms. To use optional chaining, use a question mark in place of the exclamation point:
if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}
/// Prints "Unable to retrieve the number of rooms."

///john.residence now contains an actual Residence instance, rather than nil. If we try to access numberOfRooms with the same optional chaining as before, it will now return an Int? that contains the default numberOfRooms value of 1:
if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}
/// Prints "John's residence has 1 room(s)."

//MARK: Accessing Subscripts Through Optional Chaining

///When we access a subscript on an optional value through optional chaining, we place the question mark before the subscript’s brackets, not after. The optional chaining question mark always follows immediately after the part of the expression that’s optional.
///The example below tries to retrieve the name of the first room in the rooms array of the john.residence property using the subscript defined on the Residence class. Because john.residence is currently nil, the subscript call fails:

// if let firstRoomName = john.residence?[0].name {
//    print("The first room name is \(firstRoomName).")
// } else {
//    print("Unable to retrieve the first room name.")
// }
/// Prints "Unable to retrieve the first room name."

///If we create and assign an actual Residence instance to john.residence, with one or more Room instances in its rooms array, we can use the Residence subscript to access the actual items in the rooms array through optional chaining:

//MARK: Linking Multiple Levels of Chaining

///We can link together multiple levels of optional chaining to drill down to properties, methods, and subscripts deeper within a model. However, multiple levels of optional chaining don’t add more levels of optionality to the returned value.

///To put it another way:
/// - If the type we are trying to retrieve isn’t optional, it will become optional because of the optional chaining.
/// - If the type we are trying to retrieve is already optional, it will not become more optional because of the chaining.

///Therefore:
/// - If we try to retrieve an Int value through optional chaining, an Int? is always returned, no matter how many levels of chaining are used.
/// Similarly, if we try to retrieve an Int? value through optional chaining, an Int? is always returned, no matter how many levels of chaining are used.

// Chaining on Methods with Optional Return Values

/// Previous example shows how to retrieve the value of a property of optional type through optional chaining. We can also use optional chaining to call a method that returns a value of optional type, and to chain on that method’s return value if needed.
