// 1. 학점을 입력받아 각각의 등급을 반환해주는 함수 (4.5 = A+,  4.0 = A, 3.5 = B+ ...)
func getGrade(score: Double) -> String {
    switch score {
    case 4.5:
        return "A+"
    case 4.0..<4.5:
        return "A"
    case 3.5..<4.0:
        return "B+"
    case 3.0..<3.5:
        return "B"
    case 2.5..<3.0:
        return "C+"
    case 2.0..<2.5:
        return "C"
    default:
        return "F"
    }
}
getGrade(score: 3.7)

// 2. 특정 달을 숫자로 입력 받아서 문자열로 반환하는 함수 (1 = "Jan" , 2 = "Feb", ...)
func convertMonth(for month: Int) -> String {
    switch month {
    case 1:
        return "Jan"
    case 2:
        return "Feb"
    case 3:
        return "Mar"
    case 4:
        return "Apr"
    case 5:
        return "May"
    case 6:
        return "Jun"
    case 7:
        return "Jul"
    case 8:
        return "Aug"
    case 9:
        return "Sep"
    case 10:
        return "Oct"
    case 11:
        return "Nov"
    case 12:
        return "Dec"
    default:
        return "Wrong Month"
    }
}
convertMonth(for: 7)

// 3. 세 수를 입력받아 세 수의 곱이 양수이면 true, 그렇지 않으면 false 를 반환하는 함수
func isMultiplySignPositive(args: (Int, Int, Int)) -> Bool {
    switch args {
    case let (x, y, z) where x < 0:
        if y * z < 0 {
            return true
        } else {
            return false
        }
    case let (x, y, z) where y < 0:
        if x * z < 0 {
            return true
        } else {
            return false
        }
    case let (x, y, z) where z < 0:
        if y * x < 0 {
            return true
        } else {
            return false
        }
    default:
        return true
    }
}
isMultiplySignPositive(args: (1, 4, -7))

// 4. 자연수 하나를 입력받아 그 수의 Factorial 을 구하는 함수
func factorial(of: Int) -> Int {
    var factorial = 1
    for number in 1...of {
        factorial *= number
    }
    return factorial
}
factorial(of: 5)

// 5. 자연수 두 개를 입력받아 첫 번째 수를 두 번째 수만큼 제곱하여 반환하는 함수 (2, 5 를 입력한 경우 결과는 2의 5제곱)
func exponential(base: Int, power: Int) -> Int {
    var expo = 1
    var count = 0
    while count < power {
        expo *= base
        count += 1
    }
    return expo
}
exponential(base: 2, power: 5)

// 6. 자연수 하나를 입력받아 각 자리수 숫자들의 합을 반환해주는 함수 (1234 인 경우 각 자리 숫자를 합치면 10)
func sumDigits(for num: Int) -> Int {
    var sum = 0
    var number = num
    let digitizer = 10
    
    repeat {
        let digit = number % digitizer
        sum += digit
        number /= digitizer
    } while number != 0
    
    return sum
}
sumDigits(for: 320)

// 7. 자연수 하나를 입력받아 1부터 해당 숫자 사이의 모든 숫자의 합을 구해 반환하는 함수를 만들되, 그 합이 2000 을 넘는 순간 더하기를 멈추고 바로 반환하는 함수
func sumAllOfRange(for number: Int) -> Int {
    var sum = 0
    for num in 1...number {
        sum += num
        if sum >= 2000 {
            break
        }
    }
    return sum
}
sumAllOfRange(for: 3000)

// 8. 1 ~ 50 사이의 숫자 중에서 20 ~ 30 사이의 숫자만 제외하고 그 나머지를 모두 더해 출력하는 함수
func sumExceptMiddle() {
    var sum = 0
    for number in 1...50 {
        if 20...30 ~= number {
            continue
        }
        sum += number
    }
    print(sum)
}
sumExceptMiddle()
