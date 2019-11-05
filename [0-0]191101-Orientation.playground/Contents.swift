import UIKit

/* 1. var와 let의 차이점
 * - var는 변수를 의미하고 최초 선언 이후 변경될 수 있다
 * - let은 상수를 의미하고 최초 선언 이후 변경될 수 없다
 */
var a = 10
a = 20

let b = 10
//b = 20


/* 2. 반복문 종류와 1~10까지 출력하는 코드 작성
 * - while : 주어진 조건이 false가 될 때 까지 이어지는 코드를 반복실행한다
 * - do-while : 코드가 최초 1회 실행된 후 주어진 조건이 true이면 다시 반복한다
 * - for-in : 주어진 범위 내에서(collection, range) 요소들을 순차적으로 순회하며 코드를 반복실행한다.
 */
var count1 = 1
while (count1 <= 10) {
    print(count1)
    count1 += 1
}

var count2 = 1
repeat {
    print(count2)
    count2 += 1
} while (count2 <= 10)

for count3 in 1...10 {
    print(count3)
}


/* 3. 타입 추론이란?
 * - Swift는 변수나 상수를 선언할 때 타입을 명시하지 않으면 할당된 값으로부터 타입을 추론한다.
 * - 10같은 literal 데이터는 기본적으로 타입을 갖지 않고 어딘가에서 사용되거나 할당될 때 타입이 부여된다
 * - 변수에 10을 할당하면 우선적으로 Int 타입으로 추론되지만, 10.0을 할당하면 Int타입이 될 수 없으므로 그 다음으로 Double 타입으로 추론된다.
 */
var inference1 = 10
print(inference1 is Int)    // true

var inference2 = 10.0
print(inference2 is Double) // true

var inference3: Double = 10
print(inference3 is Int)    // false


/* 4. 논리연산자 AND(&&)와 OR(||)로 나올 수 있는 경우 4가지
 * - AND 연산은 두 경우 모두 참(true)일 때만 연산 결과가 참이다
 * - OR 연산은 둘 중 한 경우만 참이어도 연산 결과가 참이다
 */

print(true && true)     // true
print(true && false)    // false
print(false && true)    // false
print(false && false)   // false

print(true || true)     // true
print(true || false)    // true
print(false || true)    // true
print(false || false)   // false
