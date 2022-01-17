import UIKit

//MARK: Deinitialization

///A deinitializer is called immediately before a class instance is deallocated. Swift removes the object from memory and marks that memory as free when an object’s reference count reaches zero.

///A deinitializer is a special method on classes that runs when an object’s reference count reaches zero but before Swift removes the object from memory.

class Person {
    var firstName = "Ilia"
    var lastName = "Tsk"
    
    deinit {
        print("\(firstName) \(lastName) is being removed from memory!")
    }
}

/*
 Much like init is a special method in class initialization, deinit is a special method that handles deinitialization. Unlike init, deinit isn’t required and is automatically invoked by Swift. We also aren’t required to override it or call super within it. Swift will make sure to call each class deinitializer.
 
 If we add this deinitializer, we'll see the message Ilia Tsk is being removed from memory! in the debug area after running the previous example.
 
 What we do in a deinitializer is up to us. Often we'll use it to clean up other resources, save state to a disk or execute any other logic you might want when an object goes out of scope.
 
 Class definitions can have at most one deinitializer per class.
 
 Superclass deinitializers are inherited by their subclasses, and the superclass deinitializer is called automatically at the end of a subclass deinitializer implementation. Superclass deinitializers are always called, even if a subclass doesn’t provide its own deinitializer.
*/
