/* [ 과제 ] */
// 1. 옵셔널 타입의 문자열 파라미터 3개를 입력받은 뒤, 옵셔널을 추출하여 Unwrapped 된 하나의 문자열로 합쳐서 반환하는 함수

func combineString(str1: String?, str2: String?, str3: String?) -> String {
    var result = ""
    
    result = str1 ?? ""
    result = str2 ?? ""
    result = str3 ?? ""
    
    return result
}
combineString(str1: "AB", str2: "CD", str3: "EF")   // "ABCDEF"
combineString(str1: "AB", str2: nil, str3: "EF")    // "ABEF"

// 2. 사칙연산(+, -, *, /)을 가진 enum 타입 Arithmetic과 2개의 자연수를 입력 파라미터로 받아 (파라미터 총 3개) 해당 연산의 결과를 반환하는 함수 구현

enum Arithmetic {
    case addition, subtraction, multiplication, division
    
    func calculate(num1: Int, num2: Int) -> Int? {
        switch self {
        case .addition:
            return num1 + num2
        case .subtraction:
            return num1 - num2
        case .multiplication:
            return num1 * num2
        case .division:
            return num2 != 0 ? num1 / num2 : nil
        }
    }
}

func calculate(num1: Int, num2: Int, operate: Arithmetic) -> Int? {
    switch operate {
    case .addition:
        return num1 + num2
    case .subtraction:
        return num1 - num2
    case .multiplication:
        return num1 * num2
    case .division:
        return num2 != 0 ? num1 / num2 : nil
    }
}
calculate(num1: 10, num2: 0, operate: .division)
Arithmetic.multiplication.calculate(num1: 10, num2: 20)



/* [ 도전 과제 ] */
// 1. celcius, fahrenheit, kelvin 온도 3가지 케이스를 가진 enum 타입 Temperature 를 정의
// 각 케이스에는 Double 타입의 Associated Value 를 받도록 함
// 추가로 Temperature 타입 내부에 각 온도를 섭씨 온도로 변환해주는 toCelcius() 함수를 구현
// 섭씨 = (화씨 - 32) * 5 / 9
// 섭씨 = 켈빈 + 273

enum Temperature {
    case celcius(Double), fahrenheit(Double), kelvin(Double)
    
    func toCelcius() -> Double {
        switch self {
        case .celcius(let celcius):
            return celcius
        case .fahrenheit(let fahrenheit):
            return (fahrenheit - 32) * 5 / 9
        case .kelvin(let kelvin):
            return kelvin + 273
        }
    }
}
let temp = Temperature.fahrenheit(90.0)
temp.toCelcius()


// 2. 다음 ArithmeticExpression 의 각 케이스별로 연산을 수행하고 그 값을 반환하는 evaluate 함수 구현
//evaluate(five)    // 결과 : 5
//evaluate(sum)     // 결과 : 9
//evaluate(product) // 결과 : 18

indirect enum ArithmeticExpression {
    case number(Int)
    case addition(ArithmeticExpression, ArithmeticExpression)
    case multiplication(ArithmeticExpression, ArithmeticExpression)
    
    func evaluate() -> Int {
        switch self {
        case .number(let num):
            return num
        case .addition(let addExp1, let addExp2):
            switch (addExp1, addExp2) {
            case (.number(let number1), .number(let number2)):
                return number1 + number2
            case (let exp, .number(let number2)):
                return exp.evaluate() + number2
            case (.number(let number1), let exp):
                return number1 + exp.evaluate()
            case (let exp1, let exp2):
                return exp1.evaluate() + exp2.evaluate()
            }
        case .multiplication(let multipleExp1, let multipleExp2):
            switch (multipleExp1, multipleExp2) {
            case (.number(let number1), .number(let number2)):
                return number1 * number2
            case (let exp, .number(let number2)):
                return exp.evaluate() * number2
            case (.number(let number1), let exp):
                return number1 * exp.evaluate()
            case (let exp1, let exp2):
                return exp1.evaluate() * exp2.evaluate()
            }
        }
    }
}

let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))

func evaluate(_ expression: ArithmeticExpression) -> Int {
    switch expression {
    case .number(let num):
        return num
    case .addition(let addExp1, let addExp2):
        switch (addExp1, addExp2) {
        case (.number(let number1), .number(let number2)):
            return number1 + number2
        case (let exp, .number(let number2)):
            return evaluate(exp) + number2
        case (.number(let number1), let exp):
            return number1 + evaluate(exp)
        case (let exp1, let exp2):
            return evaluate(exp1) + evaluate(exp2)
        }
    case .multiplication(let multipleExp1, let multipleExp2):
        switch (multipleExp1, multipleExp2) {
        case (.number(let number1), .number(let number2)):
            return number1 * number2
        case (let exp, .number(let number2)):
            return evaluate(exp) * number2
        case (.number(let number1), let exp):
            return number1 * evaluate(exp)
        case (let exp1, let exp2):
            return evaluate(exp1) * evaluate(exp2)
        }
    }
}
evaluate(five)
evaluate(sum)
evaluate(product)

five.evaluate()
sum.evaluate()
product.evaluate()

