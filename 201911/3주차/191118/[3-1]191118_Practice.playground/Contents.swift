/*
 1. width, height 속성을 가진 Rectangle 클래스 정의
 2. 생성자에서 width, height 프로퍼티 값을 설정할 수 있도록 구현
 3. 사각형의 가로 세로 길이를 설정할 수 있는 메서드 구현
 4. 사각형 가로와 세로의 길이를 반환하는 메서드 구현
 5. 사각형의 넓이를 반환하는 메서드 구현
 6. 다음과 같은 속성을 지닌 인스턴스 생성
 - 직사각형 1개 속성: width = 10, height = 5
 - 정사각형 1개 속성: width = 7, height = 7
 */

class Rectangle {
    // 1. width, height 속성을 가진 Rectangle 클래스 정의
    var width: Int
    var height: Int
    
    // 2. 생성자에서 width, height 프로퍼티 값을 설정할 수 있도록 구현
    init(width: Int, height: Int) {
        self.width = width
        self.height = height
    }
    
    // 3. 사각형의 가로 세로 길이를 설정할 수 있는 메서드 구현
    func setWidht(width: Int) {
        self.width = width
    }
    
    func setHeight(height: Int) {
        self.height = height
    }
    
    // 4. 사각형 가로와 세로의 길이를 반환하는 메서드 구현
    func getWidth() -> Int {
        return width
    }
    
    func getHeight() -> Int {
        return height
    }
    
    // 5. 사각형의 넓이를 반환하는 메서드 구현
    func getArea() -> Int {
        return width * height
    }
}

// 6. 다음과 같은 속성을 지닌 인스턴스 생성
// << 클래스 작성 -> 인스턴스 생성 -> 변수에 할당해서 객체 생성 >>
//  - 직사각형 1개 속성: width = 10, height = 5
//  - 정사각형 1개 속성: width = 7, height = 7

var rect: Rectangle = Rectangle(width: 10, height: 5)
var sqre: Rectangle = Rectangle(width: 7, height: 7)


/*
 1. 채널 정보, Volume 값, 전원 설정여부를 속성으로 가지는 클래스 정의
 2. TV 의 현재 채널 및 볼륨을 변경 가능한 메서드 구현
 3. TV 의 현재 채널 및 볼륨을 확인할 수 있는 메서드 구현
 4. TV 전원이 꺼져있을 때는 채널과 볼륨 변경을 할 수 없도록 구현
    (직접 프로퍼티에 값을 설정할 수 없다고 가정)
 5. TV 전원이 꺼져있을 때는 채널과 볼륨 정보를 확인했을 때 -1 이 반환되도록 구현
 */

class TV {
    private var channel: Int = 0
    private var volume: Int = 0
    private var power: Bool = false
    
    func change(channel: Int) {
        if power {
            self.channel = channel
        }
    }
    
    func change(volume: Int) {
        if power {
            self.volume = volume
        }
    }
    
    func currentChannel() -> Int {
        return power ? channel : -1
    }
    
    func currentVolume() -> Int {
        return power ? volume : -1
    }
    
    func onoff(_ power: Bool) {
        self.power = power
    }
}

var appleTV = TV()
appleTV.currentVolume()
appleTV.currentChannel()
appleTV.onoff(true)
appleTV.currentVolume()
appleTV.currentChannel()
appleTV.change(channel: 10)
appleTV.change(channel: 19)
appleTV.currentVolume()
appleTV.currentChannel()


/*
 1. 사각형의 길이를 설정하는 초기화 메서드, 둘레와 넓이값을 구하는 메서드 구현
 2. 원의 반지름을 설정하는 초기화 메서드, 둘레와 넓이값을 구하는 메서드 구현
 */

class Square {
    var length: Double
    
    init(length: Double) {
        self.length = length
    }
    
    func aroundLength() -> Double {
        return length * 4
    }
    
    func getArea() -> Double {
        return length * length
    }
}


class Circle {
    var radius: Double
    
    init(radius: Double) {
        self.radius = radius
    }
    
    func circumference() -> Double {
        return 2 * 3.14 * radius
    }
    
    func getArea() -> Double {
        return 3.14 * radius * radius
    }
}

let square = Square(length: 10)
square.aroundLength()
square.getArea()
let circle = Circle(radius: 10)
circle.circumference()
circle.getArea()
