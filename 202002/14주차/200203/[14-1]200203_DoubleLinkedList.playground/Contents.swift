// MARK:- Double Linked List

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

let dll = DoubleLinkedList()
dll.append(node: Node(data: "A"))
dll.append(node: Node(data: "B"))
dll.append(node: Node(data: "C"))
dll.append(node: Node(data: "D"))
dll.scanValues()

print(dll.node(by: "B")?.data ?? "")
dll.scanValues()

dll.insert(node: Node(data: "E"), at: 2)
dll.scanValues()

dll.removeNode(at: 3)
dll.scanValues()

dll.removeNode(by: "B")
dll.scanValues()

dll.removeNode(at: 1)
dll.scanValues()

dll.removeAll()
dll.scanValues()
