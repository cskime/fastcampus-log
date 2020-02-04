// MARK:- Single Linked List

protocol LinkedListStack {
  var size: Int { get }     // 전체 개수
  var isEmpty: Bool { get } // 노드가 있는지 여부
  func push(node: Node)     // 데이터 삽입
  func pop() -> String?     // 데이터 추출
  func peek() -> String?    // 마지막 데이터 확인
}
final class Node {
  var data: String?
  var next: Node?
  init(data: String?) {
    self.data = data
  }
}

final class SingleLinkedList: LinkedListStack {
  private var head: Node = Node(data: nil)
  var isEmpty: Bool { return self.head.next == nil }
  var size = 0 {
    didSet { size = size < 0 ? 0 : size }
  }
  
  private var last: Node? {
    guard var node = head.next else { return nil }
    while let nextNode = node.next { node = nextNode }
    return node
  }
  
  // MARK: Interface
  
  func push(node newNode: Node) {
    self.size += 1
    guard let node = self.last else { return self.head.next = newNode }
    node.next = newNode
  }
  
  func peek() -> String? {
    return last?.data
  }
  
  func pop() -> String? {
    guard var node = head.next else { return nil }
    while let nextNode = node.next {
      guard nextNode.next != nil else {
        node.next = nil
        return nextNode.data
      }
      node = nextNode
    }
    head.next = nil
    return node.data
  }
  
}

let linkedList = SingleLinkedList()
linkedList.push(node: Node(data: "A"))
linkedList.push(node: Node(data: "B"))
linkedList.push(node: Node(data: "C"))
linkedList.peek()

linkedList.pop()
linkedList.peek()

linkedList.pop()
linkedList.peek()

linkedList.pop()
linkedList.peek()

