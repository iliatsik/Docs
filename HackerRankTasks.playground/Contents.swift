import UIKit

////Sales By Match https://www.hackerrank.com/challenges/sock-merchant/problem?isFullScreen=true&h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=warmup
//func sockMerchant(n: Int, ar: [Int]) -> Int {
//    var set = Set<Int>()
//    var total = 0
//
//    for number in ar {
//        guard set.contains(number)  else {
//            set.insert(number)
//            continue
//        }
//        total += 1
//        set.remove(number)
//    }
//
//    return total
//}
//
//
////Counting Valleys https://www.hackerrank.com/challenges/counting-valleys/problem?isFullScreen=true&h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=warmup&h_r=next-challenge&h_v=zen
//
//func countingValleys(steps: Int, path: String) -> Int {
//    var level = path
//    var currentLevel = 0
//    var total = 0
//
//    for _ in 0..<level.count {
//        if level.first == "U" {
//            currentLevel += 1
//        } else {
//            currentLevel -= 1
//        }
//        level.removeFirst()
//        if currentLevel == 0 { total += 1}
//    }
//
//    return total - 1
//}
//
//
////2D - Array DS https://www.hackerrank.com/challenges/2d-array/problem?isFullScreen=true&h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=arrays
//
//func hourglassSum(arr: [[Int]]) -> Int {
//    var maxHourGlass = 0
//    for generalIndex in 0..<arr.count - 2 {
//        for specificIndex in 0..<arr[generalIndex].count - 2 {
//            var sum = 0
//            sum += (arr[generalIndex][specificIndex] + arr[generalIndex][specificIndex + 1] + arr[generalIndex][specificIndex + 2])
//            sum += arr[generalIndex + 1][specificIndex + 1]
//            sum += (arr[generalIndex + 2][specificIndex] + arr[generalIndex + 2][specificIndex + 1] + arr[generalIndex + 2][specificIndex + 2])
//            maxHourGlass = max(maxHourGlass, sum)
//        }
//    }
//
//    return maxHourGlass
//}
//
//// Array: Left Rotation https://www.hackerrank.com/challenges/ctci-array-left-rotation/problem?isFullScreen=true&h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=arrays&h_r=next-challenge&h_v=zen
//
//func rotLeft(a: [Int], d: Int) -> [Int] {
//    var array = a
//    for index in 0..<a.count {
//        array[index] = a[(index + d) % a.count]
//        print(a[(index + d) % a.count])
//    }
//    return array
//}
//
//// New Year Chaos https://www.hackerrank.com/challenges/new-year-chaos/problem?isFullScreen=true&h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=arrays&h_r=next-challenge&h_v=zen&h_r=next-challenge&h_v=zen
//
//func minimumBribes(q: [Int]) -> Void {
//    var totalBribe = 0
//    for (key,value) in q.enumerated() {
//        if (value - 1) - key > 2 { print("Too Chaotic"); return}
//
//        for index in stride(from: max(0, value - 2), to: key, by: 1){
//            if q[index] > value { totalBribe += 1 }
//        }
//    }
//    print(totalBribe)
//}


// Minimum  Swaps 2 https://www.hackerrank.com/challenges/minimum-swaps-2/problem?isFullScreen=true&h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=arrays&h_r=next-challenge&h_v=zen&h_r=next-challenge&h_v=zen&h_r=next-challenge&h_v=zen

func minimumSwaps(arr: [Int]) -> Int {
   return 0
}


//Sorting: Bubble Sort https://www.hackerrank.com/challenges/ctci-bubble-sort/problem?isFullScreen=true&h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=sorting
func countSwaps(a: [Int]) -> Void {
    var array = a
    var totalSwaps = 0
    
    for _ in 0..<array.count - 1{
        for exIndex in 0..<array.count - 1 {
            if array[exIndex] > array[exIndex + 1]{
                let temporary = array[exIndex]
                array[exIndex] = array[exIndex + 1]
                array[exIndex + 1] = temporary
                totalSwaps += 1
            }
        }
    }
    
    guard let firstElement = array.first else { return }
    guard let lastElement = array.last else { return }
    
    print("Array is sorted in \(totalSwaps) swaps.")
    print("First Element: \(firstElement)")
    print("Last Element: \(lastElement)")
}

//Mark and Toys https://www.hackerrank.com/challenges/mark-and-toys/problem?isFullScreen=true&h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=sorting&h_r=next-challenge&h_v=zen
func maximumToys(prices: [Int], k: Int) -> Int {
    let array = prices.sorted()
    var currency = k
    var total = 0

    
    while currency > 0 {
        currency -= array[total]
        total += 1
    }

    return total - 1
}

//Alternating Characters https://www.hackerrank.com/challenges/alternating-characters/problem?isFullScreen=true&h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=strings
func alternatingCharacters(s: String) -> Int {
    let string = Array(s)
    var total = 0
    for index in 0..<string.count - 1 { if string[index] == string[index + 1] { total += 1 } }
    return total
}

//Sherlock and the Valid String https://www.hackerrank.com/challenges/sherlock-and-valid-string/problem?isFullScreen=true&h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=strings&h_r=next-challenge&h_v=zen
func isValid(s: String) -> String {
    let string = s
    var dictionary = [Character : Int]()
    var indexDict = [Int : Int]()
    var keyFrequency = 0
    var valueFrequency = 0
    var counter = 0
    var total = 0
    
    for char in string {
        if let count = dictionary[char] { dictionary[char] = count + 1 }
        else { dictionary[char] = 1 }
    }
    
    for value in dictionary.values{
        if let count = indexDict[value] { indexDict[value] = count + 1 }
        else { indexDict[value] = 1 }
    }

    for (key, value) in indexDict { if value > valueFrequency { valueFrequency = value; keyFrequency = key } }
    
    for (_, value) in dictionary {
        if value == 1 || value == keyFrequency - 1 || value == keyFrequency + 1 { total += 1 }
        else if abs(value - keyFrequency) > 0 { counter += 1 }
    }
    
    if total <= 1 && counter == 0 {
        return "YES"
    } else {
        return "NO"
    }
    
}

