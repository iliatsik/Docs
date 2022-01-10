import UIKit

//String

/* The escaped special characters:
 \0 (null character),
 \\ (backslash),
 \t (horizontal tab),
 \n (line feed),
 \r (carriage return),
 \" (double quotation mark)
 \' (single quotation mark)
*/

//Strings Are Value Types


// There are several ways for Concatenating Strings and Characters
// 1. with the addition operator (+)
let string1 = "hello"
let string2 = " there"
var welcome = string1 + string2
// 2. with the addition assignment operator (+=)
var instruction = "look over"
instruction += string2
// 3. with the String type’s append() method
let exclamationMark: Character = "!"
welcome.append(exclamationMark)


// String Interpolation
// String interpolation is a way to construct a new String value from a mix of constants, variables, literals, and expressions by including their values inside a string literal. it is used as backslash (\).


/*String Indices
 
 Each String value has an associated index type, String.Index, which corresponds to the position of each Character
 in the string. in order to determine which Character is at a particular position, we must iterate over each Unicode
 scalar from the start or end of that String. For this reason, Swift strings can’t be indexed by integer values.
 
 Use the startIndex property to access the position of the first Character of a String. The endIndex property is the
 position after the last character in a String. As a result, the endIndex property isn’t a valid argument to a
 string’s subscript. If a String is empty, startIndex and endIndex are equal.
 
 We access the indices before and after a given index using the index(before:) and index(after:) methods of String.
 To access an index farther away from the given index, you can use the index(_:offsetBy:) method instead of calling
 one of these methods multiple times.
 */
let greeting = "Guten Tag!"
greeting[greeting.startIndex]
// G
greeting[greeting.index(before: greeting.endIndex)]
// !
greeting[greeting.index(after: greeting.startIndex)]
// u
let index = greeting.index(greeting.startIndex, offsetBy: 7)
greeting[index]
// a


//Attempting to access an index outside of a string’s range or a Character at an index outside of a string’s rang will trigger a runtime error.
  
  //greeting[greeting.endIndex] // Error
  //greeting.index(after: greeting.endIndex) // Error


// We use the indices property to access all of the indices of individual characters in a string.
for index in greeting.indices {
    print("\(greeting[index]) ", terminator: "")
}
// Prints "G u t e n   T a g ! "


/*
 We can use the startIndex and endIndex properties and the index(before:), index(after:), and index(_:offsetBy:) methods
 on any type that conforms to the Collection protocol. This includes String, as shown here, as well as collection types
 such as Array, Dictionary, and Set. This also concern for inserting and removing methods*/


/* Inserting and Removing
 
 To insert a single character into a string at a specified index, use the insert(_:at:) method, and to insert the
 contents of another string at a specified index, use the insert(contentsOf:at:) method.
*/

welcome.insert("!", at: welcome.endIndex)
// welcome now equals "hello!"

welcome.insert(contentsOf: " there", at: welcome.index(before: welcome.endIndex))
// welcome now equals "hello there!"

/* To remove a single character from a string at a specified index, use the remove(at:) method, and to remove a substring
 at a specified range, use the removeSubrange(_:) method: */
welcome.remove(at: welcome.index(before: welcome.endIndex))
// welcome now equals "hello there"

let range = welcome.index(welcome.endIndex, offsetBy: -6)..<welcome.endIndex
welcome.removeSubrange(range)
// welcome now equals "hello"

//Substrings
/* When you get a substring from a string—for example, using a subscript or a method like prefix(_:)—the result is an
 instance of Substring. When you’re ready to store the result for a longer time, We convert the substring to an
 instance of String.
 
 Substrings aren’t suitable for long-term storage—because they reuse the storage of the original string, the entire
 original string must be kept in memory as long as any of its substrings are being used. In this example, newString
 is a string—when it’s created from the substring, it has its own storage. The figure below shows these relationships. */

let greeting0 = "Hello, world!"
let index0 = greeting0.firstIndex(of: ",") ?? greeting0.endIndex
let beginning = greeting0[..<index]
// beginning is "Hello"

// Convert the result to a String for long-term storage.
let newString = String(beginning)


//Prefix and Suffix Equality
//To check whether a string has a particular string prefix or suffix, call the string’s hasPrefix(_:) and hasSuffix(_:) methods, both of which take a single argument of type String and return a Boolean value.
let romeoAndJuliet = [
    "Act 1 Scene 1: Verona, A public place",
    "Act 1 Scene 2: Capulet's mansion",
    "Act 1 Scene 3: A room in Capulet's mansion",
    "Act 1 Scene 4: A street outside Capulet's mansion",
    "Act 1 Scene 5: The Great Hall in Capulet's mansion",
]

//We can use the hasPrefix(_:) method with the romeoAndJuliet array to count the number of scenes in Act 1 of the play:

var act1SceneCount = 0
for scene in romeoAndJuliet {
    if scene.hasPrefix("Act 1 ") {
        act1SceneCount += 1
    }
}
print("There are \(act1SceneCount) scenes in Act 1")
// Prints "There are 5 scenes in Act 1"

//Similarly, We can use the hasSuffix(_:) method 
