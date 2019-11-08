// 1. 이름과 나이를 입력 받아 자기 자신을 소개하는 글을 출력하는 함수
func introduce(name: String, age: Int) -> String {
    return "안녕하세요. 저는 \(name)이고 나이는 \(age) 입니다."
}

// 2. 정수를 하나 입력받아 2의 배수 여부를 반환하는 함수
func isMultipleOfTwo(for value: Int) -> Bool {
    return value % 2 == 0
}

// 3. 정수를 두 개 입력 받아 곱한 결과를 반환하는 함수 (파라미터 하나의 기본 값은 10)
func multiplier(_ value1: Int, _ value2: Int = 10) -> Int {
    return value1 * value2
}

// 4. 4과목의 시험 점수를 입력받아 평균 점수를 반환하는 함수
func average(score1: Int, score2: Int, score3: Int, score4: Int) -> Double {
    var sum = score1 + score2 + score3 + score4
    return Double(sum) / Double(4)
}

// 5. 점수를 입력받아 학점을 반환하는 함수 만들기 (90점 이상 A, 80점 이상 B, 70점 이상 C, 그 이하 F)
func findGrade(with score: Int) -> String {
    switch score {
    case 90...:
        return "A"
    case 80..<90:
        return "B"
    case 70..<80:
        return "C"
    default:
        return "F"
    }
}

// 6. 가변 인자 파라미터를 이용해 점수를 여러 개 입력받아 평균 점수에 대한 학점을 반환하는 함수 (90점 이상 A, 80점 이상 B, 70점 이상 C, 그 이하 F)
func findGrade(scores: Int...) -> String {
    var sum = 0
    for score in scores {
        sum += score
    }
    return findGrade(with: sum / scores.count)
}
