/*
[ 과제 - 알고리즘 ]
1. 정수 하나를 입력받은 뒤, 해당 숫자와 숫자 1사이에 있는 모든 정수의 합계 구하기
e.g.  5 -> 1 + 2 + 3 + 4 + 5 = 15,   -2 -> -2 + -1 + 0 + 1 = -2
 */

func sum(at number: Int) -> Int {
    var sum = 0
    var count = number
    
    if number > 1 {
        for value in 1...number {
            sum += value
        }
    } else if number < 1 {
        for value in number...1 {
            sum += value
        }
    } else {
        return 1
    }

    return sum
}
sum(at: 5)
sum(at: -2)


/*
2. 숫자를 입력받아 1부터 해당 숫자까지 출력하되, 3, 6, 9가 하나라도 포함되어 있는 숫자는 *로 표시
e.g.  1, 2, *, 4, 5, *, 7, 8, *, 10, 11, 12, *, 14, 15, * ...
 */

func printExceptThree(at number: Int) {
    for num in 1...number {
        if String(num).contains("3") || String(num).contains("6") || String(num).contains("9") {
            print("*", terminator: " ")
        } else {
            print(num, terminator: " ")
        }
    }
}
printExceptThree(at: 20)


/*
3. 2개의 정수를 입력했을 때 그에 대한 최소공배수와 최대공약수 구하기
e.g.  Input : 6, 9   ->  Output : 18, 3
// 최대공약수
// 1) 두 수 중 큰 수를 작은 수로 나눈 나머지가 0이면 최대 공약수
// 2) 나머지가 0이 아니면, 큰 수에 작은 수를 넣고 작은 수에 나머지 값을 넣은 뒤 1) 반복
// 최소 공배수
// - 주어진 두 수의 곱을 최대공약수로 나누면 최소공배수
*/

// 최대공약수
func GCDandLCM(rhs: Int, lhs: Int) -> (gcd: Int, lcm: Int) {
    var gcd = 0, lcm = 0
    var maxV = max(rhs, lhs)
    var minV = min(rhs, lhs)
    
    while true {
        var rest = maxV % minV
        if rest == 0 {
            gcd = minV
            break
        } else {
            maxV = minV
            minV = rest
        }
    }
    
    lcm = rhs * lhs / gcd
    
    return (gcd, lcm)
}
GCDandLCM(rhs: 6, lhs: 9)
