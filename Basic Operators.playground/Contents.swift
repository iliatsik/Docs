import UIKit

// Basic Operators

/* Terminology
 
 OPERATORS are:
 
 - Unary operators operate on a single target (such as -a). Unary prefix operators appear immediately before their target
   (such as !b), and unary postfix operators appear immediately after their target (such as c!).
 - Binary operators operate on two targets (such as 2 + 3) and are infix because they appear in between their two targets.
 - Ternary operators operate on three targets. Like C, Swift has only one ternary operator, the ternary conditional operator
   (a ? b : c).
 */


// Unary Minus and Plus Operators

let three = 3
let minusThree = -three       // minusThree equals -3
let plusThree = -minusThree   // plusThree equals 3, or "minus minus three"

let minusSix = -6
let alsoMinusSix = +minusSix  // alsoMinusSix equals -6


// Compound Assignment Operators
// It is: += and -=

var a = 0
a += 2 //shorthand version of a = a+2
a -= 2 //                     a = a-2


//Ternary Conditional Operator
//The ternary conditional operator is a special operator with three parts, which takes the form question ? answer1 : answer2

let contentHeight = 40
let hasHeader = true
let rowHeight0 = contentHeight + (hasHeader ? 50 : 20) // it is a shorthand version of if statement
var rowHeight1 = 0

if hasHeader {
    rowHeight1 = contentHeight + 50
} else {
    rowHeight1 = contentHeight + 20
} //This is a longer version of ternary operator


//Nil-Coalescing Operator
//The nil-coalescing operator (a ?? b) unwraps an optional a if it contains a value, or returns a default value b if a is nil.
let defaultColorName = "red"
var userDefinedColorName: String?   // defaults to nil

var colorNameToUse = userDefinedColorName ?? defaultColorName
// userDefinedColorName is nil, so colorNameToUse is set to the default of "red"


//Range Operators

// Closed Range Operator

// The closed range operator (a...b) defines a range that runs from a to b, and includes the values a and b. The value
// of a must not be greater than b.

for index in 1...5 {
    print(index) // prints: 1, 2, 3, 4, 5
}

//Half-Open Range Operator
//The half-open range operator (a..<b) defines a range that runs from a to b, but doesn’t include b
for index in 0..<4 {
    print(index) // prints: 0, 1, 2, 3,
}

//One-Sided Ranges
//The closed range operator has an alternative form for ranges that continue as far as possible in one direction—for
//example, a range that includes all the elements of an array from index 2 to the end of the array.
let names = ["Anna", "Alex", "Brian", "Jack"]
for name in names[2...] {
    print(name) // prints: Brian, Jack
}

