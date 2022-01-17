import UIKit

//MARK: Error Handling

//MARK: What is error handling?
///Imagine we’re in the desert and we decide to surf the internet. We’re miles away from the nearest hotspot with no cellular signal. We open our internet browser. What happens? Does our browser hang there forever with a spinning wheel of death, or does it immediately alert us to the fact that we have no internet access?
///When we’re designing the user experience for our apps, we must think about the error states. Think about what can go wrong, how we want our app to respond, and how we want to surface that information to users to allow them to act on it appropriately.

//MARK: Map and compactMap

class Toy { // Just several Class with optional chaining
    enum Kind {
        case ball, zombie, bone, mouse
    }
    enum Sound {
        case squeak, bell
    }
    let kind: Kind
    let color: String
    var sound: Sound?
    init(kind: Kind, color: String, sound: Sound? = nil) {
        self.kind = kind
        self.color = color
        self.sound = sound
    } }

class Pet {
    enum Kind {
        case dog, cat, guineaPig
    }
    let name: String
    let kind: Kind
    let favoriteToy: Toy?
    init(name: String, kind: Kind, favoriteToy: Toy? = nil) {
        self.name = name
        self.kind = kind
        self.favoriteToy = favoriteToy
    } }
class Person {
    let pet: Pet?
    init(pet: Pet? = nil) {
        self.pet = pet
    }
}
let janie = Person(pet: Pet(name: "Delia", kind: .dog,
                            favoriteToy: Toy(kind: .ball,
                                             color: "Purple", sound: .bell)))
let tammy = Person(pet: Pet(name: "Evil Cat Overlord",
                            kind: .cat, favoriteToy: Toy(kind: .mouse,
                                                         color: "Orange")))
let felipe = Person()

///Let’s say we want to create an array of pets the team owns. First off, we need to create an array of team members:
let team = [janie, tammy, felipe]
///We want to iterate through this array and extract all pet names. We could use a for loop, but there is a better way to do this: map.
let petNames = team.map { $0.pet?.name }

for pet in petNames {
    print(String(describing: pet))  ///prints pet names
}
///The compiler generates warning. Instead of having a nice list of names, we have many optional values and even a nil! And at this point, that is not a good approach

///We could take this array, filter it and then call map again to unwrap all the values that are not nil, but that seems somewhat convoluted.So there is a better way to accomplish: compactMap.
let betterPetNames = team.compactMap { $0.pet?.name }
for pet in betterPetNames {
print(pet) } /// prints output without optional and nil.
///compactMap does a regular map operation and potentially “compacts” or shrinks the result array’s size.

//MARK: Error Protocol
///Swift includes the Error protocol, which forms the basis of the error-handling architecture. Any type that conforms to this protocol represents an error. Any named type can conform to the Error, but it’s especially well-suited to enumerations.
class Pastry {
    let flavor: String
    var numberOnHand: Int
    init(flavor: String, numberOnHand: Int) {
        self.flavor = flavor
        self.numberOnHand = numberOnHand
    }
}

enum BakeryError: Error {
    case tooFew(numberOnHand: Int), doNotSell, wrongFlavor
    case inventory, noPower
}

//MARK: Throwing errors
///What does our program do with these errors? It throws them, of course! That’s the actual terminology we’ll see: throwing errors then catching them.
class Bakery {
    var itemsForSale = [
        "Cookie": Pastry(flavor: "ChocolateChip", numberOnHand: 20),
        "PopTart": Pastry(flavor: "WildBerry", numberOnHand: 13),
        "Donut" : Pastry(flavor: "Sprinkles", numberOnHand: 24),
        "HandPie": Pastry(flavor: "Cherry", numberOnHand: 6)
    ]
    func open(_ now: Bool = Bool.random()) throws -> Bool {
        guard now else {
            throw Bool.random() ? BakeryError.inventory : BakeryError.noPower
        }
        return now
    }
    func orderPastry(item: String,
                     amountRequested: Int,
                     flavor: String)  throws  -> Int {
        guard let pastry = itemsForSale[item] else {
            throw BakeryError.doNotSell
        }
        guard flavor == pastry.flavor else {
            throw BakeryError.wrongFlavor
        }
        guard amountRequested <= pastry.numberOnHand else {
            throw BakeryError.tooFew(numberOnHand: pastry.numberOnHand)
        }
        pastry.numberOnHand -= amountRequested
        return pastry.numberOnHand
    }
}
///As this example shows, we throw errors using throw. The errors we throw must be instances of a type that conforms to Error. A function (or method) that throws errors and does not immediately handle them must clarify this by adding throws to its declaration.

//MARK: Handling errors
///After our program throws an error, we need to handle that error. There are two ways to approach this problem: Immediately handling our errors or bubble them up to another level.
///To choose our approach, we need to think about where it makes the most sense to handle the error. If it makes sense to handle the error immediately, then do so. Suppose we’re in a situation where we have to alert the user and have her take action, but we’re several function calls away from a user interface element. In that case, it makes sense to bubble up the error until we reach the point where we can alert the user.
///It’s up to us at what level in our call stack to handle the error, but not handling it isn’t an option. Swift requires us to deal with the error at some point in the chain, or our program won’t compile.
let bakery = Bakery()
do {
    try bakery.open()
    try bakery.orderPastry(item: "Albatross",
                           amountRequested: 1,
                           flavor: "AlbatrossFlavor")
} catch BakeryError.inventory, BakeryError.noPower {
    print("Sorry, the bakery is now closed.")
} catch BakeryError.doNotSell {
    print("Sorry, but we don’t sell this item.")
} catch BakeryError.wrongFlavor {
    print("Sorry, but we don’t carry this flavor.")
} catch BakeryError.tooFew {
    print("Sorry, we don’t have enough items to fulfill your order.")
}

//MARK: Not looking at the detailed error
///If we don’t care about the error details, we can use try? to wrap the result of a function (or method) in an optional. The function will then return nil instead of throwing an error. No need to set up a do {} catch {} block.
let open = try? bakery.open(false)
let remaining = try? bakery.orderPastry(item: "Albatross", amountRequested: 1, flavor: "AlbatrossFlavor")
///This code is nice and short to write, but the downside is that we don’t get any details if the request fails.

//MARK: Stoping our program on an error
///Sometimes we know for sure that our code is not going to fail. For example, if we certainly know the bakery is now open and we just restocked the cookie jar, we’ll be able to order a cookie.
do {
    try bakery.open(true)
    try bakery.orderPastry(item: "Cookie", amountRequested: 1, flavor: "ChocolateChip")
} catch {
    fatalError()
}
///Swift gives us a short way to write the same thing:
try! bakery.open(true)
try! bakery.orderPastry(item: "Cookie", amountRequested: 1, flavor: "ChocolateChip")
///We should be extra careful when using try! and avoid it in production code.


//MARK: Sample Project PugBot
///The PugBot isometimes  gets lost and as the programmer of the PugBot, it’s our responsibility to make sure it doesn’t get lost on the way home

///First, we need to set up an enum containing all of the directions our PugBot can move:
enum Direction {
    case left, right, forward
}
///We’ll also need an error type to indicate what can go wrong:
enum PugBotError: Error {
    case invalidMove(found: Direction, expected: Direction)
    case endOfPath
}
///PugBot Class
class PugBot {
    let name: String
    let correctPath: [Direction]
    private var currentStepInPath = 0
    init(name: String, correctPath: [Direction]) {
        self.correctPath = correctPath
        self.name = name
    }
    func move(_ direction: Direction) throws {
        guard currentStepInPath < correctPath.count else {
            throw PugBotError.endOfPath
        }
        let nextDirection = correctPath[currentStepInPath]
        guard nextDirection == direction else {
            throw PugBotError.invalidMove(found: direction,
                                          expected: nextDirection)
        }
        currentStepInPath += 1
    }
    func reset() {
        currentStepInPath = 0
    }
}
///When creating a PugBot, we tell it how to get home by passing it the correct directions. move(_:) causes the PugBot to move in the corresponding direction. If at any point the program notices the PugBot isn’t doing what it’s supposed to do, it throws an error.

///Test pugBot:
let pug = PugBot(name: "Pug",
                 correctPath:
[.forward, .left, .forward, .right])
func goHome() throws {
  try pug.move(.forward)
  try pug.move(.left)
  try pug.move(.forward)
  try pug.move(.right)
}
do {
  try goHome()
} catch {
  print("PugBot failed to get home.")
}
///Every single command in goHome() must pass for the method to complete successfully. The moment an error is thrown, our PugBot will stop trying to get home and will stay put until we come and rescue it.

//MARK: Handling multiple errors in PugBot
func moveSafely(_ movement: () throws -> ()) -> String {
  do {
    try movement()
    return "Completed operation successfully."
  } catch PugBotError.invalidMove(let found, let expected) {
    return "The PugBot was supposed to move \(expected), but moved \(found) instead."
  } catch PugBotError.endOfPath {
    return "The PugBot tried to move past the end of the path."
} catch {
    return "An unknown error occurred."
  }
}
///This function takes a movement function (like goHome()) or a closure containing movement function calls and handles any errors thrown.
///Swift’s do-try-catch system isn’t type-specific. There’s no way to tell the compiler that it should only expect PugBotErrors. To the compiler, that isn’t exhaustive because it doesn’t handle every possible error that it knows about, so we still need a default case. Now we can use our function to handle movement safely:
pug.reset()
moveSafely(goHome)
pug.reset()
moveSafely {
  try pug.move(.forward)
  try pug.move(.left)
  try pug.move(.forward)
  try pug.move(.right)
}

//MARK: Rethrows
///A function that takes a throwing closure as a parameter has to choose: either catch every error or be a throwing function. Let’s say we want a utility function to perform a certain movement or set of movements several times in a row.
func perform(times: Int, movement: () throws -> ()) rethrows {
  for _ in 1...times {
    try movement()
  }
}
///Notice the rethrows here. This function does not handle errors like moveSafely(_:). Instead, it leaves error handling to the function’s caller, such as goHome(). The above function uses rethrows to indicate that it will only rethrow errors thrown by the closure passed into it, and it will never throw errors of its own.

//MARK: Throwable properties
///We can throw errors from read-only computed properties:
// 1
class _Person {
  var name: String
  var age: Int
  init(name: String, age: Int) {
    self.name = name
    self.age = age
  }
}
// 2
enum PersonError: Error {
  case noName, noAge, noData
}
// 3
extension _Person {
  var data: String {
    get throws {
      guard !name.isEmpty else {throw PersonError.noName}
      guard age > 0 else {throw PersonError.noAge}
      return "\(name) is \(age) years old."
} }
}

//In Action:
let me = _Person(name: "Cosmin", age: 36)
me.name = ""
do {
  try me.data
} catch {
  print(error) // "noName"
}
me.age = -36
do {
  try me.data
} catch {
  print(error) // "noName"
}
me.name = "Cosmin"
do {
  try me.data
} catch {
  print(error) // "noAge"
}
me.age = 36
do {
  try me.data // "Cosmin is 36 years old."
} catch {
  print(error)
}
