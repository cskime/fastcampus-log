# Linked List

- Data를 갖는 단위로 `Node`라는 개념을 사용
- 자기 자신의 data와 주변 `Node`를 가리키는 포인터 정보를 가짐

## Single Linked List

- 하나의 pointer member로 다른 `Node`를 가리키는 구조
- `HEAD` node에서 시작해서 `TAIL` 방향으로 데이터가 연결되어 나가는 구조. `HEAD`의 next node가 없으면 Linked List가 비어있는 것.
- 앞으로 돌아갈 수 없고, 중간에 있는 데이터에 바로 접근할 수 없음
- `HEAD` node의 주소를 잃어버리면 데이터 전체에 접근할 수 있는 방법이 없음
- Queue를 구현할 때 많이 사용됨

```swift
class Node {
  var data: String?		// Node가 갖는 데이터
  var next: Node?			// 다음 node
  init(data: String?) { self.data = data }
}

class SingleLinkedList {
	// SLL의 시작점으로 head를 항상 갖고 있어야 함
 	private var head = Node(data: nil)
  
  // SLL이 비어있는지 확인
  var isEmpty: Bool { return self.head.next == nil }
  
  // SLL의 크기(Node의 개수)
  var size = 0 {
    didSet { size = size < 0 ? 0 : size }
  }
  
  // SLL의 마지막 Node
  private var last: Node? {
    guard var node = head.next else { return nil }
    while let nextNode = node.next { node = nextNode }
    return node
  }
  
  // Insert. 항상 끝에 추가됨
  func push(node newNode: Node) {
		defer { size += 1 }
    guard let node = self.last else { return self.head.next = newNode }
    node.next = newNode
  }
  
  // Delete. 항상 끝에서 삭제됨
  func pop() -> Node? {
		guard !self.isEmpty else { return nil }
    
  	let node = head
    while let nextNode = node.next {
      guard nextNode.next != nil else {
				node.next = nil
        return nextNode
      }
      node = nextNode
    }
    return nil
  }
}
```

## Double Linked List

- Single Linked List에서 이전(previous) `Node`까지 연결된 linked list
- Previous node가 없으면 `HEAD`, next가 없으면 `TAIL`
- 이전, 다음 node의 주소를 가질 수 있기 때문에 chain이 끊어졌을 때 복구할 수 있고, chain의 중간에 데이터 삽입/삭제가 쉽다

```swift
class Node {
  var data: String?
  var next: Node?
  var prev: Node?
  init(data: String?) {
    self.data = data
  }
  deinit {
    print("Node(\(data ?? "")) is Deinitialized")
  }
}

class DoubleLinkedList {
  private var head = Node(data: nil)
  private weak var tail: Node?
  
  var isEmpty: Bool { return self.head.next == nil }
  var count: Int = 0 { didSet { count = count < 0 ? 0 : count } }
  var first: Node? { return head.next }
  var last: Node? {
    guard var node = head.next else { return nil }
    while let nextNode = node.next { node = nextNode }
    return node
  }
  
  func scanValues() {
    var node = head
    while let nextNode = node.next {
      print(nextNode.data ?? "", terminator: " ")
      node = nextNode
    }
    print()
  }
  
  func removeAll() {
    guard var node = last else { return }
    while let prevNode = node.prev {
      prevNode.next = nil
      node = prevNode
    }
  }
  
  func removeNode(by value: String) -> Bool {
    var node = head
    while let nextNode = node.next {
      if nextNode.data == value {
        let prev = nextNode.prev
        let next = nextNode.next
        prev?.next = next
        nextNode.next = nil
        
        next?.prev = prev
        nextNode.prev = nil
        return true
      } else {
        node = nextNode
      }
    }
    return false
  }
  
  func removeNode(at index: Int) -> String? {
    var node = head
    var indexCount = 0
    while let nextNode = node.next {
      if indexCount == index {
        let prev = nextNode.prev
        let next = nextNode.next
        let data = nextNode.data
        prev?.next = next
        nextNode.next = nil
        
        next?.prev = prev
        nextNode.prev = nil
        return data
      } else {
        node = nextNode
        indexCount += 1
      }
    }
    return nil
  }
  
  func node(by value: String) -> Node? {
    var node = head
    while let nextNode = node.next {
      if nextNode.data == value {
        return nextNode
      } else {
        node = nextNode
      }
    }
    return nil
  }
  
  func insert(node newNode: Node, at index: Int) {
    var node = head
    var indexCount = 0
    while let nextNode = node.next {
      if indexCount == index {
        let prev = nextNode.prev
        
        prev?.next = newNode
        newNode.prev = prev
        
        nextNode.prev = newNode
        newNode.next = nextNode
      } else {
        node = nextNode
        indexCount += 1
      }
    }
  }
  
  func append(node newNode: Node) {
    count += 1
    guard var node = head.next else {
      head.next = newNode
      newNode.prev = head
      return
    }
    while let nextNode = node.next { node = nextNode }
    node.next = newNode
    newNode.prev = node
  }
}
```

## Circular Linked List

- `HEAD`와 `TAIL`을 제외한 `Node`들 중 처음 노드와 끝 노드가 서로 연결된 구조
- 할당된 메모리 공간 삭제 및 재할당의 부담이 없음
- Stream 버퍼의 구현 및 큐 구현에 많이 사용됨

# Array vs. Linked List

## Array

- 구조
  - Array는 data와 상관 없이 초기 할당되는 메모리 사이즈가 고정되며, 데이터의 크기가 초기 메모리 사이즈를 벗어나면 바로 뒤에 이어서 새로운 메모리 공간을 할당한다
  - 뒤에 이어붙일 공간이 없다면, 초기 메모리 사이즈의 2배 크기로 새로운 메모리 공간으로 옮긴 뒤 데이터를 저장한다.
  - 즉, 연속된 데이터 공간을 유지하려는 특성 때문에 구조가 단순하지만, 데이터가 계속 변하는 경우 미리 할당해 두는 사용하지 않는 메모리 공간 때문에 메모리 낭비로 이어질 수 있다.
- 값의 접근
  - Array는 저장하는 데이터 타입이 모두 동일해야 한다
  - Array에 저장된 데이터 타입에 따라 메모리 사이즈가 결정된다.(`Int` 타입 데이터가 저장되어 있다면, 데이터 당 할당된 메모리 사이즈는 8byte = 64bit). 이 사이즈를 이용해서 index에 따라 `데이터 타입의 크기 x index`로 메모리 상의 위치(주소)가 어디인지 계산할 수 있다.

## Linked List

- 구조
  - Linked List는 데이터를 뒤에 하나씩 이어붙여 나가는 구조이기 때문에, 사용하지 않는 공간을 미리 가질 필요가 없고 구조 및 사이즈를 유연하게 변경할 수 있다.
  - Linked List는 데이터를 찾기 위해 메모리 사이즈를 직접 계산할 수 없으므로 다양한 타입의 데이터를 저장할 수 있다.
- 값의 접근
  - 공간이 필요할 때 마다 추가하고, 그 주소를 연결하기 때문에 데이터들이 메모리상에 여기저기 흩어져 있다. `next`, `prev` 등의 pointer를 이용해서 순회한다.
  - 데이터 타입에 상관없이 데이터를 저장하는 경우, array가 아닌 linked list로 구현되어 있다고 생각할 수 있다.