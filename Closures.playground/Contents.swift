import UIKit

//Closures
/// Closures are self-contained blocks of functionality that can be passed around and used in your code. Closures in Swift are similar to blocks in C and Objective-C and to lambdas in other programming languages.
/// Closures can capture and store references to any constants and variables from the context in which they’re defined. This is known as closing over those constants and variables. Swift handles all of the memory management of capturing for you.

//Closures take one of three forms:
/// * Global functions are closures that have a name and don’t capture any values.
/// * Nested functions are closures that have a name and can capture values from their enclosing function.
/// * Closure expressions are unnamed closures written in a lightweight syntax that can capture values from their surrounding context.

//Swift’s closure optimizations include:
/// * Inferring parameter and return value types from context
/// * Implicit returns from single-expression closures
/// * Shorthand argument names
/// * Trailing closure syntax


//Closure Expression Syntax
let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}
var reversedNames = names.sorted(by: backward)

reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in
    return s1 > s2
})
//Inferring Type From Context
reversedNames = names.sorted(by: { s1, s2 in return s1 > s2 } )
//Implicit Returns from Single-Expression Closures
reversedNames = names.sorted(by: { s1, s2 in s1 > s2 } )
//Shorthand Argument Names
reversedNames = names.sorted(by: { $0 > $1 } )
//Operator Methods
reversedNames = names.sorted(by: >)


//Trailing Closures
///If we need to pass a closure expression to a function as the function’s final argument and the closure expression is long, it can be useful to write it as a trailing closure instead. You write a trailing closure after the function call’s parentheses, even though the trailing closure is still an argument to the function. When we use the trailing closure syntax, we don’t write the argument label for the first closure as part of the function call. A function call can include multiple trailing closures; however, the first few examples below use a single trailing closure.

func someFunctionThatTakesAClosure(closure: () -> Void) {
    // function body goes here
}

/// Here's how we call this function without using a trailing closure:
someFunctionThatTakesAClosure(closure: {
    // closure's body goes here
})

/// Here's how we call this function with a trailing closure instead:
someFunctionThatTakesAClosure() {
    // trailing closure's body goes here
}

///The string-sorting closure from the Closure Expression Syntax section above can be written outside of the sorted(by:) method’s parentheses as a trailing closure:
reversedNames = names.sorted() { $0 > $1 }

///If a closure expression is provided as the function’s or method’s only argument and we provide that expression as a trailing closure, we don’t need to write a pair of parentheses () after the function or method’s name when we call the function:
reversedNames = names.sorted { $0 > $1 }


//Capturing Values
///A closure can capture constants and variables from the surrounding context in which it’s defined. The closure can then refer to and modify the values of those constants and variables from within its body, even if the original scope that defined the constants and variables no longer exists.
func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal  /// captures value
    }
    return incrementer
}

let incrementByTen = makeIncrementer(forIncrement: 10) /// curent value is 10

//Closures Are Reference Types
let alsoIncrementByTen = incrementByTen
alsoIncrementByTen()
/// returns a value of 20

incrementByTen()
/// returns a value of 30


//Escaping Closures
///A closure is said to escape a function when the closure is passed as an argument to the function, but is called after the function returns. When we declare a function that takes a closure as one of its parameters, we can write @escaping before the parameter’s type to indicate that the closure is allowed to escape. So, to say that harshly, it means to be called later.

///For Example:
var completionHandlers: [() -> Void] = []
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}
/// Writing self explicitly lets us express our intent, and reminds us to confirm that there isn’t a reference cycle.

/// In the code below, the closure passed to someFunctionWithEscapingClosure(_:) refers to self explicitly. In contrast, the closure passed to someFunctionWithNonescapingClosure(_:) is a nonescaping closure, which means it can refer to self implicitly.
func someFunctionWithNonescapingClosure(closure: () -> Void) {
    closure()
}

class SomeClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure { self.x = 100 }
        someFunctionWithNonescapingClosure { x = 200 }
    }
}

let instance = SomeClass()
instance.doSomething()
print(instance.x)
/// Prints "200"

completionHandlers.first?()
print(instance.x)
/// Prints "100"


///  It is a version of doSomething() that captures self by including it in the closure’s capture list, and then refers to self implicitly:
class SomeOtherClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure { [self] in x = 100 }
        someFunctionWithNonescapingClosure { x = 200 }
    }
}


struct SomeStruct {
    var x = 10
    mutating func doSomething() {
        someFunctionWithNonescapingClosure { x = 200 }  // Ok
//        someFunctionWithEscapingClosure { x = 100 }    // Error
    }
}
///If we are using Struct instead of class, then we have declare functions and methods and mutating,because Structures and enumerations don’t allow shared mutability, as discussed in Structures and Enumerations Are Value Types.
///The call to the someFunctionWithEscapingClosure function in the example above is an error because it’s inside a mutating method, so self is mutable. That violates the rule that escaping closures can’t capture a mutable reference to self for structures.


//Autoclosures
///An autoclosure is a closure that’s automatically created to wrap an expression that’s being passed as an argument to a function. It doesn’t take any arguments, and when it’s called, it returns the value of the expression that’s wrapped inside of it. This syntactic convenience lets us omit braces around a function’s parameter by writing a normal expression instead of an explicit closure.
///An autoclosure lets us delay evaluation, because the code inside isn’t run until you call the closure. Delaying evaluation is useful for code that has side effects or is computationally expensive, because it lets you control when that code is evaluated. The code below shows how a closure delays evaluation.
var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count)
// Prints "5"

let customerProvider = { customersInLine.remove(at: 0) }
print(customersInLine.count)
// Prints "5"

print("Now serving \(customerProvider())!")
// Prints "Now serving Chris!"
print(customersInLine.count)
// Prints "4"
///Even though the first element of the customersInLine array is removed by the code inside the closure, the array element isn’t removed until the closure is actually called. If the closure is never called, the expression inside the closure is never evaluated, which means the array element is never removed. Note that the type of customerProvider isn’t String but () -> String—a function with no parameters that returns a string.


///We get the same behavior of delayed evaluation when you pass a closure as an argument to a function.
// customersInLine is ["Alex", "Ewa", "Barry", "Daniella"]
func serve(customer customerProvider: () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: { customersInLine.remove(at: 0) } )
// Prints "Now serving Alex!"

///The serve(customer:) function in the listing above takes an explicit closure that returns a customer’s name. The version of serve(customer:) below performs the same operation but, instead of taking an explicit closure, it takes an autoclosure by marking its parameter’s type with the @autoclosure attribute. Now you can call the function as if it took a String argument instead of a closure. The argument is automatically converted to a closure, because the customerProvider parameter’s type is marked with the @autoclosure attribute.
///customersInLine is ["Ewa", "Barry", "Daniella"]
func serve(customer customerProvider: @autoclosure () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: customersInLine.remove(at: 0))
/// Prints "Now serving Ewa!"



//Closure example:
//How to simplify function with closure

///We are using the function, which takes array and compare function as parameters and returns Int value
func generic(array: [Int], compare: (Int, Int) -> Bool) -> Int {
    var value = array[0]
    for item in array {
        if compare(value, item) {
            value = item
        }
    }
    return value
}

//1

///then we are usin two function, which compares two values and return Boolean
func compareMin(_ number1: Int, _ number2: Int) -> Bool {
    return number1 > number2
}

func compareMax(_ number1: Int, _ number2: Int) -> Bool {
    return number1 < number2
}

///Last, we are calling generic function and passing array and comparing function
generic(array: [12, 2, 3, 4], compare: compareMin(_:_:))
generic(array: [12, 2, 3, 4], compare: compareMax(_:_:))


//2
///At this point, we are still passing array, but, now, instead of passing function we are declaring n1 and n2 in the caller which returns boolean
generic(array: [12, 2, 3, 4], compare: { (n1: Int, n2: Int) -> Bool in return n1 > n2 })
generic(array: [12, 2, 3, 4], compare: { (n1: Int, n2: Int) -> Bool in return n1 < n2 })


//3
/// It is almost same as 2, but here, we do not need to declare n1 and n2 as integers, cause compiler knows what type will be passed in the function
generic(array: [12, 2, 3, 4], compare: { n1, n2 -> Bool in return n1 > n2 })
generic(array: [12, 2, 3, 4], compare: { n1, n2 -> Bool in return n1 < n2 })


//4
/// It is shorthand version of above examples, we are using $0 and etc. and we are using it as closure parameters.
generic(array: [12, 2, 3, 4], compare: { $0 > $1 })
generic(array: [12, 2, 3, 4], compare: { $0 < $1 })
