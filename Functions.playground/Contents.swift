import UIKit

//Functions

//Variadic Parameters in Functions
//A variadic parameter accepts zero or more values of a specified type. We use a variadic parameter to specify that the parameter can be passed a varying number of input values when the function is called. Write variadic parameters by inserting three period characters (...) after the parameter’s type name.

func arithmeticMean(_ numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}
arithmeticMean(1, 2, 3, 4, 5)
// returns 3.0, which is the arithmetic mean of these five numbers
arithmeticMean(3, 8.25, 18.75)
// returns 10.0, which is the arithmetic mean of these three numbers


//In-Out Parameters
//Function parameters are constants by default. Trying to change the value of a function parameter from within the body of that function results in a compile-time error. This means that we can’t change the value of a parameter by mistake. If we want a function to modify a parameter’s value, and we want those changes to persist after the function call has ended, define that parameter as an in-out parameter instead.
//You write an in-out parameter by placing the inout keyword right before a parameter’s type.
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}
var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
// Prints "someInt is now 107, and anotherInt is now 3"


//Using Function Types
//We use function types just like any other types in Swift. For example, we can define a constant or variable to be of a function type and assign an appropriate function to that variable:
func addTwoInts(_ a: Int, _ b: Int) -> Int {
    return a + b
}
var mathFunction: (Int, Int) -> Int = addTwoInts
//The addTwoInts(_:_:) function has the same type as the mathFunction variable, and so this assignment is allowed by Swift’s type-checker.


//As with any other type, you can leave it to Swift to infer the function type when you assign a function to a constant or variable:
let anotherMathFunction = addTwoInts
// anotherMathFunction is inferred to be of type (Int, Int) -> Int


//Function Types as Parameter Types
//You can use a function type such as (Int, Int) -> Int as a parameter type for another function. This enables you to leave some aspects of a function’s implementation for the function’s caller to provide when the function is called.
func printMathResult(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    print("Result: \(mathFunction(a, b))")
}
printMathResult(addTwoInts, 3, 5)
// Prints "Result: 8"
