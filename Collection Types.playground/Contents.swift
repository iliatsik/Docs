import UIKit

// Swift provides three primary collection types, known as arrays, sets, and dictionaries
// Arrays are ordered collections of values. Sets are unordered collections of unique values. Dictionaries are unordered collections of key-value associations.

//Mutability of Collections
/* If you create an array, a set, or a dictionary, and assign it to a variable, the collection that’s created will be mutable. This means that you can change (or mutate) the collection after it’s created by adding, removing, or changing items in the collection. If you assign an array, a set, or a dictionary to a constant, that collection is immutable, and its size and contents can’t be changed.
*/


//Arrays

//Array Type Shorthand Syntax
/* The type of a Swift array is written in full as Array<Element>, where Element is the type of values the array is allowed to store. You can also write the type of an array in shorthand form as [Element]. Although the two forms are functionally identical, the shorthand form is preferred and is used throughout this guide when referring to the type of an array.
*/


//Creating an Array with a Default Value

// Swift’s Array type also provides an initializer for creating an array of a certain size with all of its values set to the same default value. You pass this initializer a default value of the appropriate type (called repeating): and the number of times that value is repeated in the new array (called count):

var threeDoubles = Array(repeating: 0.0, count: 3)
// threeDoubles is of type [Double], and equals [0.0, 0.0, 0.0]

//.count  counts the number of items in an array,

//.isEmpty checking whether the count property is equal to 0

// Add a new item to the end of an array by calling the array’s append(_:) method or use addition assignment operator (+=)

// Call to the insert(_:at:) method inserts a new item with a value of "Some String" at the very beginning of the array, indicated by an index.

// Similarly, we remove an item from the array with the remove(at:) method.

// If you want to remove the final item from an array, use the removeLast() method

// You can iterate over the entire set of values in an array with the for-in loop:

var shoppingList: [String] = ["Eggs", "Milk"]

for item in shoppingList {
    print(item) // prints Eggs, Milk
}

/*If you need the integer index of each item as well as its value, use the enumerated() method to iterate over the
 array instead. For each item in the array, the enumerated() method returns a tuple composed of an integer and the item.
 The integers start at zero and count up by one for each item; if you enumerate over a whole array, these integers match
 the items’ indices. You can decompose the tuple into temporary constants or variables as part of the iteration:
 */
for (index, value) in shoppingList.enumerated() {
    print("Item \(index + 1): \(value)") // prints Item 1: Eggs, Item 2: Milk
}


//Sets
//  A set stores distinct values of the same type in a collection with no defined ordering. You can use a set instead of an array when the order of items isn’t important, or when you need to ensure that an item only appears once.



/*A type must be hashable in order to be stored in a set—that is, the type must provide a way to compute a hash value
  for itself. A hash value is an Int value that’s the same for all objects that compare equally, such that if a == b, the
  hash value of a is equal to the hash value of b.

  All of Swift’s basic types (such as String, Int, Double, and Bool) are hashable by default, and can be used as set value
  types or dictionary key types. Enumeration case values without associated values (as described in Enumerations) are
  also hashable by default.
 */

//You can create an empty set of a certain type using initializer syntax:

var letters = Set<Character>()

letters.insert("a")
// letters now contains 1 value of type Character
letters = []
// letters is now an empty set, but is still of type Set<Character>

// You can also initialize a set with an array literal, as a shorthand way to write one or more values as a set collection.
var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]
// Or
var favoriteGenres0: Set = ["Rock", "Classical", "Hip hop"]
// favoriteGenres has been initialized with three initial items

//  We can remove an item from a set by calling the set’s remove(_:) method, which removes the item if it’s a member of the set, and returns the removed value, or returns nil if the set didn’t contain it. Alternatively, all items in a set can be removed with its removeAll() method.

if let removedGenre = favoriteGenres.remove("Rock") {
    print("\(removedGenre)? I'm over it.")
}

//To check whether a set contains a particular item, use the contains(_:) method.

if favoriteGenres.contains("Funk") {
    print("I get up on the good foot.")
}

//We can iterate over the values in a set with a for-in loop as it is in Arrays

//  Swift’s Set type doesn’t have a defined ordering. To iterate over the values of a set in a specific order, use the sorted() method, which returns the set’s elements as an array sorted using the < operator.

for genre in favoriteGenres.sorted() {
    print("\(genre)")
}
// Classical
// Hip hop
// Jazz

//Fundamental Set Operations
/*
 - Use the intersection(_:) method to create a new set with only the values common to both sets.
 - Use the symmetricDifference(_:) method to create a new set with values in either set, but not both.
 - Use the union(_:) method to create a new set with all of the values in both sets.
 - Use the subtracting(_:) method to create a new set with values not in the specified set.
 */
let oddDigits: Set = [1, 3, 5, 7, 9]
let evenDigits: Set = [0, 2, 4, 6, 8]
let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]

oddDigits.union(evenDigits).sorted()
// [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
oddDigits.intersection(evenDigits).sorted()
// []
oddDigits.subtracting(singleDigitPrimeNumbers).sorted()
// [1, 9]
oddDigits.symmetricDifference(singleDigitPrimeNumbers).sorted()
// [1, 2, 9]


//Set Membership and Equality
/*
 - Use the “is equal” operator (==) to determine whether two sets contain all of the same values.
 - Use the isSubset(of:) method to determine whether all of the values of a set are contained in the specified set.
 - Use the isSuperset(of:) method to determine whether a set contains all of the values in a specified set.
 - Use the isStrictSubset(of:) or isStrictSuperset(of:) methods to determine whether a set is a subset or superset, but not equal to, a specified set.
 - Use the isDisjoint(with:) method to determine whether two sets have no values in common.
 */
let houseAnimals: Set = ["🐶", "🐱"]
let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
let cityAnimals: Set = ["🐦", "🐭"]

houseAnimals.isSubset(of: farmAnimals)
// true
farmAnimals.isSuperset(of: houseAnimals)
// true
farmAnimals.isDisjoint(with: cityAnimals)
// true


//Dictionaries
/*
 A dictionary stores associations between keys of the same type and values of the same type in a collection with no
 defined ordering. Each value is associated with a unique key, which acts as an identifier for that value within
 the dictionary. Unlike items in an array, items in a dictionary don’t have a specified order. You use a dictionary
 when you need to look up values based on their identifier, in much the same way that a real-world dictionary is used
 to look up the definition for a particular word.
 */

//The type of a Swift dictionary is written in full as Dictionary<Key, Value>, where Key is the type of value that can be used as a dictionary key, and Value is the type of value that the dictionary stores for those keys.

//You can also write the type of a dictionary in shorthand form as [Key: Value]. Although the two forms are functionally identical, the shorthand form is preferred and is used throughout this guide when referring to the type of a dictionary.

//Creating an Empty Dictionary
var namesOfIntegers: [Int: String] = [:]

namesOfIntegers[16] = "sixteen"
// namesOfIntegers now contains 1 key-value pair
namesOfIntegers = [:]
// namesOfIntegers is once again an empty dictionary of type [Int: String]

//Creating a Dictionary with a Dictionary Literal
var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]

// shorter form
var airports0 = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]

//Same methods for dictionaries as array and setss. such as: isEmpty, count and etc.

//We can add a new item to a dictionary with subscript syntax. Use a new key of the appropriate type as the subscript index, and assign a new value of the appropriate type:
airports["LHR"] = "London"
// the airports dictionary now contains 3 items

//We can also use subscript syntax to change the value associated with a particular key:
airports["LHR"] = "London Heathrow"
// the value for "LHR" has been changed to "London Heathrow"


//As an alternative to subscripting, use a dictionary’s updateValue(_:forKey:) method to set or update the value for a particular key. Unlike a subscript, however, the updateValue(_:forKey:) method returns the old value after performing an update. This enables you to check whether or not an update took place.

if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB") {
    print("The old value for DUB was \(oldValue).")
}
// Prints "The old value for DUB was Dublin."

//We can also use subscript syntax to retrieve a value from the dictionary for a particular key. Because it’s possible to request a key for which no value exists, a dictionary’s subscript returns an optional value of the dictionary’s value type.

if let airportName = airports["DUB"] {
    print("The name of the airport is \(airportName).")
} else {
    print("That airport isn't in the airports dictionary.")
}
// Prints "The name of the airport is Dublin Airport."

//We can use subscript syntax to remove a key-value pair from a dictionary by assigning a value of nil for that key:
airports["APL"] = "Apple International"
// "Apple International" isn't the real airport for APL, so delete it
airports["APL"] = nil
// APL has now been removed from the dictionary

//Alternatively, remove a key-value pair from a dictionary with the removeValue(forKey:) method. This method removes the key-value pair if it exists and returns the removed value, or returns nil if no value existed:

if let removedValue = airports.removeValue(forKey: "DUB") {
    print("The removed airport's name is \(removedValue).")
} else {
    print("The airports dictionary doesn't contain a value for DUB.")
}
// Prints "The removed airport's name is Dublin Airport."

//Iterating Over a Dictionary
for (airportCode, airportName) in airports {
    print("\(airportCode): \(airportName)")
}
// LHR: London Heathrow
// YYZ: Toronto Pearson

//We can also retrieve an iterable collection of a dictionary’s keys or values by accessing its keys and values properties:

for airportCode in airports.keys {
    print("Airport code: \(airportCode)")
}
// Airport code: LHR
// Airport code: YYZ

for airportName in airports.values {
    print("Airport name: \(airportName)")
}
// Airport name: London Heathrow
// Airport name: Toronto Pearson
