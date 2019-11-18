/*
 1. 다음과 같은 속성(Property)과 행위(Method)를 가지는 클래스 만들어보기. 구현 내용은 자유롭게
 
 ** 강아지 (Dog)
 - 속성: 이름, 나이, 몸무게, 견종
 - 행위: 짖기, 먹기
 */

class Dog {
    var name: String
    var age: Int
    var weight: Double
    var breed: String
    
    init(name: String, age: Int, weight: Double, breed: String) {
        self.name = name
        self.age = age
        self.weight = weight
        self.breed = breed
    }
    
    func bark() {
        print("Bowwow")
    }
    
    func eat() {
        print("chapchap")
    }
}

var sake = Dog(name: "Sake", age: 2, weight: 50, breed: "Golden Retriver")

/*
 
 ** 학생 (Student)
 - 속성: 이름, 나이, 학교명, 학년
 - 행위: 공부하기, 먹기, 잠자기
 
 */
class Student {
    var name: String
    var age: Int
    var school: String
    var grade: Int
    
    init(name: String, age: Int, school: String, grade: Int) {
        self.name = name
        self.age = age
        self.school = school
        self.grade = grade
    }
    
    func study() {
        print("Burnning")
    }
    
    func eat() {
        print("eat chicken every day")
    }
    
    func sleep() {
        print("Sleep forever")
    }
}

var cskim = Student(name: "cskim", age: 28, school: "CBNU", grade: 4)

/*
 
 ** 아이폰(IPhone)
 - 속성: 기기명, 가격, faceID 기능 여부(Bool)
 - 행위: 전화 걸기, 문자 전송
 
 */
class IPhone {
    var model: String
    var price: Int
    var canUseFaceID: Bool = false
    
    init(model: String, price: Int) {
        self.model = model
        self.price = price
        if model == "iPhone X", model == "iPhone Xs", model == "iPhone 11 Pro" {
            canUseFaceID = true
        }
    }
    
    func call() {
        print("Call to Tim Cook")
    }
    
    func message() {
        print("Messaging to Tim Cook")
    }
}

var myPhone = IPhone(model: "iPhone Xs", price: 1_390_000)
myPhone.call()
myPhone.message()

/*
 ** 커피(Coffee)
 - 속성: 이름, 가격, 원두 원산지
 */

class Coffee {
    var name: String
    var price: Int
    var origin: String
    
    init(name: String, price: Int, origin: String) {
        self.name = name
        self.price = price
        self.origin = origin
    }
}

var americano = Coffee(name: "Americano", price: 2000, origin: "PPaek")


/*
 2. 계산기 클래스를 만들고 다음과 같은 기능을 가진 Property 와 Method 정의해보기
 
 ** 계산기 (Calculator)
 - 속성: 현재 값
 - 행위: 더하기, 빼기, 나누기, 곱하기, 값 초기화
 
 ex)
 let calculator = Calculator() // 객체생성
 
 calculator.value  // 0
 calculator.add(10)    // 10
 calculator.add(5)     // 15
 
 calculator.subtract(9)  // 6
 calculator.subtract(10) // -4
 
 calculator.multiply(4)   // -16
 calculator.multiply(-10) // 160
 
 calculator.divide(10)   // 16
 calculator.reset()      // 0
 */

class Calculator {
    var current: Int = 0
    
    func add(_ value: Int) {
        current += value
    }
    
    func subtract(_ value: Int) {
        current -= value
    }
    
    func multiply(_ value: Int) {
        current *= value
    }
    
    func divide(_ value: Int) {
        if value != 0 {
            current /= value
        }
    }
    
    func reset() {
        current = 0
    }
}

let calculator = Calculator() // 객체생성

calculator.current  // 0
calculator.add(10)    // 10
calculator.add(5)     // 15

calculator.subtract(9)  // 6
calculator.subtract(10) // -4

calculator.multiply(4)   // -16
calculator.multiply(-10) // 160

calculator.divide(10)   // 16
calculator.reset()      // 0


/*
 3. 첨부된 그림을 참고하여 각 도형별 클래스를 만들고 각각의 넓이, 둘레, 부피를 구하는 프로퍼티와 메서드 구현하기
 */

class Square {
    var length: Double
    
    init(length: Double) {
        self.length = length
    }
    
    func getArea() -> Double {
        return length * length
    }
    
    func getPerimeter() -> Double {
        return length * 4
    }
}

class Rectangle {
    var width: Double
    var height: Double
    
    init(width: Double, height: Double) {
        self.width = width
        self.height = height
    }
    
    func getArea() -> Double {
        return width * height
    }
    
    func getPerimeter() -> Double {
        return 2 * width + 2 * height
    }
}

class Circle {
    var radius: Double
    
    init(radius: Double) {
        self.radius = radius
    }
    
    func getArea() -> Double {
        return 3.14 * radius * radius
    }
    
    func getCircumference() -> Double {
        return 2 * 3.14 * radius
    }
}

class Triangle {
    var below: Double
    var height: Double
    
    init(below: Double, height: Double) {
        self.below = below
        self.height = height
    }
    
    func getArea() -> Double {
        return below * height / 2
    }
}

class Trapezoid {
    var upper: Double
    var below: Double
    var height: Double
    
    init(upper: Double, below: Double, height: Double) {
        self.upper = upper
        self.below = below
        self.height = height
    }
    
    func getArea() -> Double {
        return (upper + below) * height / 2
    }
}

class Cube {
    var square: Square
    
    init(length: Double) {
        square = Square(length: length)
    }
    
    func getArea() -> Double {
        return square.getArea() * 6
    }
}

class RectangularSolid {
    var face1: Rectangle
    var face2: Rectangle
    var face3: Rectangle
    
    init(width: Double, height: Double, vertical: Double) {
        face1 = Rectangle(width: width, height: height)
        face2 = Rectangle(width: height, height: vertical)
        face3 = Rectangle(width: width, height: vertical)
    }
    
    func getArea() -> Double {
        return face1.getArea() + face2.getArea() + face3.getArea()
    }
}

class CircularCylinder {
    var circle: Circle
    var height: Double
    
    init(radius: Double, height: Double) {
        circle = Circle(radius: radius)
        self.height = height
    }
    
    func getArea() -> Double {
        return 2 * circle.getArea() * height
    }
}

class Sphere {
    var circle: Circle
    var radius: Double
    
    init(radius: Double) {
        self.radius = radius
        circle = Circle(radius: radius)
    }
    
    func getArea() -> Double {
        return circle.getArea() * radius * 4 / 3
    }
}

class Cone {
    var circle: Circle
    var height: Double
    
    init(radius: Double, height: Double) {
        circle = Circle(radius: radius)
        self.height = height
    }
    
    func getArea() -> Double {
        return circle.getArea() * height / 3
    }
}
