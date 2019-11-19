/* Q. 상속 적용해보기
 *  - 이미지처럼 Animal, Human, Pet, Dog, Cat 클래스 정의
 *  - 상속을 적용해 필요한 속성을 모두 가지면서도 각각 다른 속성과 값을 지닐 수 있도록 구현
 */


class Animal {
    var brain = true
    var legs: Int { get { return 0 } }
}

class Human: Animal {
    override var legs: Int { get { return 2 } }
}

class Pet: Animal {
    override var legs: Int { get { return 4 } }
    var fleas: Int { get { return 0 } }
}

class Dog: Pet {
    override var fleas: Int { get { return 8 } }
}

class Cat: Pet {
    override var fleas: Int { get { return 4 } }
}

let animal = Animal()
animal.brain
animal.legs

let human = Human()
human.brain
human.legs

let pet = Pet()
pet.brain
pet.legs
pet.fleas

let dog = Dog()
dog.brain
dog.legs
dog.fleas

let cat = Cat()
cat.brain
cat.legs
cat.fleas

