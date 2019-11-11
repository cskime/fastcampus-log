import Foundation

// 1. 두 개의 자연수를 입력받아 두 수를 하나의 숫자로 이어서 합친 결과를 정수로 반환하는 함수
func decomposeDigit(for num: Int) -> [Int] {
    var number = num
    var stack = [Int]()
    
    while number != 0 {
        stack.append(number % 10)
        number /= 10
    }
    return stack
}

func square(_ num: Int, of: Int) -> Int {
    var result = 1
    for _ in 1...of {
        result *= num
    }
    return result
}

func appendNumber(num1: Int, num2: Int) -> Int {
    var fStack = decomposeDigit(for: num1)
    var rStack = decomposeDigit(for: num2)
    
    var result = 0
    for index in (1..<fStack.count + rStack.count).reversed() {
        if !fStack.isEmpty {
            result += fStack.removeLast() * square(10, of: index)
        } else {
            result += rStack.removeLast() * square(10, of: index)
        }
    }
    return result
}
appendNumber(num1: 1, num2: 320)


// 2. 문자열 두 개를 입력받아 두 문자열이 같은지 여부를 판단해주는 함수
func isEqualString(str1: String, str2: String) -> Bool {
    return str1 == str2
}
isEqualString(str1: "Apple", str2: "apple")

// 3. 자연수를 입력받아 그 수의 약수를 모두 출력하는 함수
func findPrime(for number: Int) {
    for num in 1...number {
        if number % num == 0 {
            print(num)
        }
    }
}
findPrime(for: 24)

// 4. 100 이하의 자연수 중 3과 5의 공배수를 모두 출력하는 함수
func commonMultiply() {
    for number in 1...100 {
        if number % 3 == 0, number % 5 == 0 {
            print(number)
        }
    }
}
commonMultiply()

// 5. 2 이상의 자연수를 입력받아, 소수인지 아닌지를 판별하는 함수
func isPrime(_ natural: Int) -> Bool {
    for number in stride(from: 2.0, through: sqrt(Double(natural)), by: 1.0) {
        if natural % Int(number) == 0 {
            return false
        }
    }
    return true
}
isPrime(11)

// 6. 자연수 하나를 입력받아 피보나치 수열 중에서 입력받은 수에 해당하는 자리의 숫자를 반환하는 함수
func fibonacci(at index: Int) -> Int {
    var first = 0, second = 1
    
    var head = 2
    while true {
        let next = first + second
        first = second
        second = next
        head += 1
        
        if head == index {
            return second
        }
    }
}
fibonacci(at: 9)

// 7. 정수를 입력받아 윤년(2월 29일이 있는 해)인지 아닌지 판단하는 함수
func isLeapYear(_ year: Int) -> Bool {
    if year % 400 == 0 || year % 100 != 0 && year % 4 == 0 {
        return true
    } else {
        return false
    }
}
isLeapYear(2000)
