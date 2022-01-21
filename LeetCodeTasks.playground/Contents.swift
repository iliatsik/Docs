import UIKit

// Concatenation of Array  https://leetcode.com/problems/concatenation-of-array/
func getConcatenation(_ nums: [Int]) -> [Int] {
    let len = nums.count
    var res = [Int](repeating: 0, count: len*2)
    for i in 0..<len {
        res[i] = nums[i]
        res[i+len] = nums[i]
    }
    return res
}


//Build Array from Permutation https://leetcode.com/problems/build-array-from-permutation/
func buildArray(_ nums: [Int]) -> [Int] {
    return nums.map { nums[$0] }
}

//Maximum Number of Words Found in Sentences https://leetcode.com/problems/maximum-number-of-words-found-in-sentences/
func mostWordsFound(_ sentences: [String]) -> Int {
    return sentences.map { $0.filter {$0 == " "}.count }.max()! + 1
}

//Final Value of Variable After Performing Operations https://leetcode.com/problems/final-value-of-variable-after-performing-operations/
func finalValueAfterOperations(_ operations: [String]) -> Int {
    var value = 0
    
    for operation in operations {
        if operation.contains("-") { value -= 1 }
        else { value += 1 }
    }
    
    return value
}

//Running Sum of 1d Array https://leetcode.com/problems/running-sum-of-1d-array/
func runningSum(_ nums: [Int]) -> [Int] {
    var sumOfArray = [Int]()
    var previousSum = 0
    
    for index in 0..<nums.count {
        previousSum += nums[index]
        sumOfArray.append(previousSum)
    }
    
    return sumOfArray
}

//Defanging an IP Address https://leetcode.com/problems/defanging-an-ip-address/
func defangIPaddr(_ address: String) -> String {
    return  address.replacingOccurrences(of: ".", with: "[.]")
}

//Fizz Buzz https://leetcode.com/problems/fizz-buzz/
func fizzBuzz(_ n: Int) -> [String] {
    var array = [String]()
    
    for index in 1...n {
        
        if index % 3 == 0 && index % 5 == 0 { array.append("FizzBuzz") }
        else if index % 3 == 0 { array.append("Fizz") }
        else if index % 5 == 0 { array.append("Buzz") }
        else { array.append("\(index)")}
    }
    
    return array
}

//Shuffle the Array https://leetcode.com/problems/shuffle-the-array/
func shuffle(_ nums: [Int], _ n: Int) -> [Int] {
    var array = [Int]()
    
    for index in n..<(2 * n) {
        array.append(nums[index - n])
        array.append(nums[index])
    }
    
    return array
}

//Richest Customer Wealth https://leetcode.com/problems/richest-customer-wealth/
func maximumWealth(_ accounts: [[Int]]) -> Int {
    var wealth = 0
    var sum = 0
    for account in accounts {
        for num in account {
            sum += num
            if sum > wealth { wealth = sum }
        }
        sum = 0
    }
    return wealth
}

//Kids With the Greatest Number of Candies https://leetcode.com/problems/kids-with-the-greatest-number-of-candies/
func kidsWithCandies(_ candies: [Int], _ extraCandies: Int) -> [Bool] {
    var boolResult = [Bool]()
    let maxNumber = candies.max()
    
    for index in 0..<candies.count {
        print(maxNumber ?? 0)
        if (candies[index] + extraCandies >= (maxNumber ?? 0)) { boolResult.append(true) }
        else { boolResult.append(false) }
    }
    
    return boolResult
}

//Number of Good Pairs https://leetcode.com/problems/number-of-good-pairs/
func numIdenticalPairs(_ nums: [Int]) -> Int {
    var counter = [Int: Int]()
    var total: Int = 0
    
    for number in nums {
        if let previousCount = counter[number] {
            counter[number] = previousCount + 1
        } else {
            counter[number] = 0
        }
    }
    
    for (_, value) in counter {
        let numberOfPairs = value * (value + 1) / 2
        total = total + numberOfPairs
    }
    
    return total
    
}

//Jewels and Stones https://leetcode.com/problems/jewels-and-stones/
func numJewelsInStones(_ jewels: String, _ stones: String) -> Int {
    return stones.filter({ jewels.contains($0) }).count
}

//Design Parking System https://leetcode.com/problems/design-parking-system/

class ParkingSystem {
    var big : Int
    var medium : Int
    var small : Int
    
    init(_ big: Int, _ medium: Int, _ small: Int) {
        self.big = big
        self.medium = medium
        self.small = small
    }
    
    func addCar(_ carType: Int) -> Bool {
        switch carType {
        case 1:
            big -= 1
            return big >= 0
        case 2:
            medium -= 1
            return medium >= 0
        case 3:
            small -= 1
            return small >= 0
        default:
            return false
        }
    }
}

//  How Many Numbers Are Smaller Than the Current Number https://leetcode.com/problems/how-many-numbers-are-smaller-than-the-current-number/
func smallerNumbersThanCurrent(_ nums: [Int]) -> [Int] {
    var array = [Int]()
    
    for index in 0..<nums.count {
        array.append(nums.filter({ nums[index] > $0 }).count)
    }
    return array
}

// Decode XORed Array https://leetcode.com/problems/decode-xored-array/
func decode(_ encoded: [Int], _ first: Int) -> [Int] {
    var result = [first]
    var decoded = first
    for encode in encoded {
        decoded = encode ^ decoded
        result.append(decoded)
    }
    return result
}

//Subtract the Product and Sum of Digits of an Integer https://leetcode.com/problems/subtract-the-product-and-sum-of-digits-of-an-integer/

func subtractProductAndSum(_ n: Int) -> Int {
    var number = n
    var sumOfDigits = 0
    var productOfDigits = 1
    while number > 0 {
        sumOfDigits += number % 10
        productOfDigits *= number % 10
        number /= 10
    }
    return productOfDigits - sumOfDigits
}

//Shuffle String https://leetcode.com/problems/shuffle-string/
func restoreString(_ s: String, _ indices: [Int]) -> String {
    var output = Array(s)
    let s = Array(s)
    
    for (index, value) in indices.enumerated() {
        output[value] = s[index]
    }
    
    return String(output)
}

