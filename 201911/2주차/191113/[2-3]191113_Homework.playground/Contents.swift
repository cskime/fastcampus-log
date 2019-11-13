// [ 과제 ]
//- 자연수를 입력받아 원래 숫자를 반대 순서로 뒤집은 숫자를 반환하는 함수
//  ex) 123 -> 321 , 10293 -> 39201

func squareOfTen(power: Int) -> Int {
    var multiply = 1
    var count = 0
    while count < power {
        multiply *= 10
        count += 1
    }
    return multiply
}

squareOfTen(power: 2)

func decomposeDigit(for number: Int) -> [Int] {
    var stack = [Int]()
    
    var share = number
    while share != 0 {
        let rest = share % 10
        stack.append(rest)
        share /= 10
    }
    return stack.reversed()
}

func reversed(_ number: Int) -> Int {
    var result = 0
    var digitArr = decomposeDigit(for: number)
    for item in digitArr.enumerated() {
        result += item.element * squareOfTen(power: digitArr.count - item.offset - 1)
    }
    return result
}
reversed(10293)


//- 100 ~ 900 사이의 숫자 중 하나를 입력받아 각 자리의 숫자가 모두 다른지 여부를 반환하는 함수
//  ex) true - 123, 310, 369   /  false - 100, 222, 770

func isAllDigitDiff(_ number: Int) -> Bool {
    let digitArr = decomposeDigit(for: number)
    let digitSet = Set<Int>(digitArr)
    return digitSet.count == digitArr.count
}
isAllDigitDiff(100)


//[ 도전 과제 ]
//- 주어진 문자 배열에서 중복되지 않는 문자만을 뽑아내 배열로 반환해주는 함수
//  ex) ["a", "b", "c", "a", "e", "d", "c"]  ->  ["b", "e" ,"d"]

func nonOverlapedChar(_ strArr: [String]) -> [String] {
    var origin = strArr
    var result = [String]()
    for item in strArr {
        if !origin.isEmpty {
            let str = origin.removeFirst()
            if origin.contains(str) {
                while let index = origin.firstIndex(of: str) {
                    origin.remove(at: index)
                }
            } else {
                result.append(str)
            }
        } else {
            break
        }
    }
    return result
}
nonOverlapedChar(["a", "b", "c", "a", "e", "d", "c"])


//- 별도로 전달한 식육목 모식도 라는 자료를 보고 Dictionary 자료형에 맞도록 중첩형태로 데이터를 저장하고 + 해당 변수에서 표범 하위 분류를 찾아 사자와 호랑이를 출력하기

let 식육목 = [
    "개과": [
        "개": [
            "자칼",
            "늑대",
            "북미산 이리",
        ],
        "여우": [
            "아메리카 여우",
            "유럽 여우",
        ],
    ],
    "고양이과": [
        "고양이": [
            "고양이",
            "살쾡이",
        ],
        "표범": [
            "사자",
            "호랑이",
        ]
    ]
]

if let 고양이과 = 식육목["고양이과"], let 표범 = 고양이과["표범"] {
    print(표범)
}
