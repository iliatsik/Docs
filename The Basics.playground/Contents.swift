import UIKit

//The Basics
//
//

/* Many parts of Swift is based on C or Objective-C. Despite the simiilarity, with the syntax, we can see a lot of changes too. e.g: Array, Set, Dictionary and Constants are actually more powerful. Besides, Swift is provided with Tuple, which can create, pass or return multiple values. In Swift, Optional is more coherent and makes a lot of sense, instead of Objective-C, where nil is considered as an Optional, Swift's optional can be used for any types, not just a classes. It shows if the value is nil or not.
 */

// Declaration of Constants and variables

let constants = 10
var variable = 10

// If we are sure, that the stored value won't change at all, we have to declare it as an let keyword, because of safety.


// We can Declare values with type annotations, but, after the declaring, swift automatically provides with its type. e.g:

let integer0 = 10      // Value is automatically defined as Int
let integer1 : Int = 1 // Usually, we are not using this method with values. We are using it with some uncertainty.

// For example if we want to declare a value of float:
let floatNum0  = 2.5 // floatNum0 is inferred to be of type Double
let floatNum1 : Float = 2.55 // floatNum0 is inferred to be of type Float
 

/* Constant and variable names can contain almost any character, including Unicode characters, except whitespace characters, mathematical symbols, arrows and nor can they begin with a number, although numbers may be included elsewhere within the name */
let 🐶 = "Dog"


print(_:separator:terminator:) /* function - Prints its output in Xcode’s “console” pane. The separator and terminator parameter have default values, so you can omit them when you call this function. By default, the function terminates the line it prints by adding a line break */


/* Semicolons
 
   Unlike many other languages, Swift doesn’t require to write a semicolon (;) after
   each statement in your code, although we can do so if we wish. However, semicolons
   are required if we want to write multiple separate statements on a single line: */
let str = "string";


/* Integers
 
 Integers are whole numbers, Swift provides signed and unsigned integers in 8, 16, 32,
 and 64 bit forms.
 
 Int
 - On a 32-bit platform, Int is the same size as Int32.
 - On a 64-bit platform, Int is the same size as Int64.
 Even on 32-bit platforms, Int can store any value between -2,147,483,648 and 2,147,483,647
 
 Unsigned int in swift is called UInt. It means, that it only contains non-negative numbers. It is also on a 32-bit and 64-bit platforms.
 */



/* Double and Float
 
 Floating-point numbers are numbers with a fractional component. Swift provides two
 signed floating-point number types:
 - Double represents a 64-bit floating-point number.
 - Float represents a 32-bit floating-point number.
 
 Double has a precision of at least 15 decimal digits, whereas the precision of Float
 can be as little as 6 decimal digits. In situations where either type
 would be appropriate, Double is preferred.
 */



/* Numeric Literals

 Integer literals can be written as:
 - A decimal number, with no prefix
 - A binary number, with a 0b prefix
 - An octal number, with a 0o prefix
 - A hexadecimal number, with a 0x prefix
 */

let decimalInteger = 17
let binaryInteger = 0b10001       // 17 in binary notation
let octalInteger = 0o21           // 17 in octal notation
let hexadecimalInteger = 0x11     // 17 in hexadecimal notation

/*
 Floating-point literals can be decimal (with no prefix), or hexadecimal
 (with a 0x prefix). They must always have a number (or hexadecimal number) on both
 sides of the decimal point.
 
 - 25e2 means 1.25 x 102, or 125.0.
 - 25e-2 means 1.25 x 10-2, or 0.0125.

 - 0xFp2 means 15 x 22, or 60.0.
 - 0xFp-2 means 15 x 2-2, or 3.75.
 */
let decimalDouble = 12.1875
let exponentDouble = 1.21875e1
let hexadecimalDouble = 0xC.3p0
 
/*
 Numeric literals can contain extra formatting to make them easier to read. Both integers and floats can be padded with extra zeros and can contain underscores to help with readability. Neither type of formatting affects the underlying value of the literal:
*/
let paddedDouble = 000123.456
let oneMillion = 1_000_000
let justOverOneMillion = 1_000_000.000_000_1


/* Typealias
 Type aliases define an alternative name for an existing type. You define type aliases
 with the typealias keyword.
 */
typealias StudentName = String
let name : StudentName = "Ilia"


/*
 Booleans
 Swift has a basic Boolean type, called Bool. Boolean values are referred to as
 logical, because they can only ever be true or false. Swift provides two Boolean
 constant values, TRUE and FALSE
 */

let lifeHasNoMeaning = true
let AiIsDestroying = false

/*
 Tuples
 It group multiple values into a single compound value. The values within a tuple can
 be of any type and don’t have to be of the same type as each other.
 
 We can have (Int, Int, Int), or (String, Bool), or indeed any other permutation
 we require.
 */
let person = (name: "Ilia", age: 19)
print("\(person.name) is \(person.age) years old")

//If we only need some of the tuple’s values,we ignore parts of the tuple with an underscore (_) when we decompose the tuple:
let (justMyName, _) = person
print("My name is \(justMyName)")
// Prints "My name is Ilia"

//Alternatively, access the individual element values in a tuple using index
//numbers starting at zero:
let myName = person.0
let myAge = person.1

/*
 Optionals
 An optional represents two possibilities: Either there is a value, and you can unwrap
 the optional to access that value, or there isn’t a value at all. If it fails it
 returns nil. there are four ways to unwrap optionals:
 */

// 1. Forced Unwrap
let x : Int? = 25
let a : Int? = x!
// Actually , it is unsafe, because we are not sure if it contains a value or not, so it could crash the code


// 2. Optional binding
if let integer = x {
  print("Integer was successfully unwrapped and is = \(integer)")
}
// This is safe method to unwrap the optional. because at first, we are checking if the value is nil or not, and after that, we are implementing our intentions in the blocks.

// 3. Guard statement
 
func checkColorInPalette() {
  let colors : [String] = ["red", "green", "blue"]

  guard let index = colors.firstIndex(where: {$0.elementsEqual("green")}) else {
    print("green is not present in palette")
    return
  }

  print("green is present in palette at position \(index)")
}
//guard let is designed to exit the current function, loop, or condition if the check fails.

/*
 Difference between if let and guard let
 
 - if let is similar to if condition with the additional functionality of defining
   let variable where we can do the computation or optional unwrapping.
 - guard let is also similar to if let but it focus on the "happy path" means
   if the condition is not true, code will not execute further in that particular
   function, loop or condition but it will return, break or throw.
 - In if let, the defined let variables are available within the scope of that if
   condition but not in else condition or even below that.
 - In guard let, the defined let variables are not available in the else condition
   but after that, it's available throughout till the function ends or anything.
 */

