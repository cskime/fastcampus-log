//
//  ViewController.swift
//  DispatchQueueExample
//
//  Created by giftbot on 2020. 2. 12..
//  Copyright © 2020년 giftbot. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
  
  @IBOutlet private weak var testView: UIView!

  @IBAction private func buttonDidTap(_ sender: Any) {
    print("---------- [ Change Color ] ----------\n")
    let r = CGFloat.random(in: 0...1.0)
    let g = CGFloat.random(in: 0...1.0)
    let b = CGFloat.random(in: 0...1.0)
    testView.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1)
  }

  func bigTask() {
    print("= Big task start =")
    for _ in 0...5_000_000 { _ = 1 + 1 }
    print("= Big task end =")
  }
  
  @IBAction func bigTaskOnMainThread() {
    bigTask()
    // Main Queue는 serial queue
    // async를 명시하지 않으면 sync처럼 동작
    // bitTask가 완전히 끝나야 다음 작업을 수행할 수 있다
  }
  
  
  @IBAction func uiTaskOnBackgroundThread() {
    print("\n---------- [ uiTaskOnBackgroundThread ] ----------\n")
    
    DispatchQueue.global().async {
      self.bigTask()
      DispatchQueue.main.async {
        self.buttonDidTap(self)
      }
    }
    // Global Queue는 concurrent queue
    // Color 변화는 UI관련 작업이기 때문에 global queue에서 처리하면
    // 색이 늦게 바뀌거나 충돌이 날 수 있음. Color 변화는 main thread에서 동작하도록 main queue에 전달해야 함
  }
  
  
  func log(_ str: String) {
    print(str, terminator: " - ")
  }
  
  @IBAction private func serialSyncOrder(_ sender: UIButton) {
    print("\n---------- [ Serial Sync ] ----------\n")
    let serialQueue = DispatchQueue(label: "kr.giftbot.serialQueue")
    // sync : 호출한 함수가 종료되어야 다음 작업 진행
    serialQueue.sync { log("1") }
    log("A")
    serialQueue.sync { log("2") }
    log("B")
    serialQueue.sync { log("3") }
    log("C")
    print()
  }
  
  @IBAction private func serialAsyncOrder(_ sender: UIButton) {
    print("\n---------- [ Serial Async ] ----------\n")
    let serialQueue = DispatchQueue(label: "kr.giftbot.serialQueue")
    // ABC 순서 동일, 123 순서 동일
    // Dispatch queue엥 작업을 전달하면, queue가 작업을 갖고 있다가 system이 적절한 시점에 여유 thread에 작업을 할당함
    // Async는 queue에 작업을 넘기고 바로 종료. 다음 실행으로 넘어감
    // 작업을 넘긴 queue가 serial queue이기 때문에 123 순서는 보장됨
    // sync와 async의 차이 : async는 앞에꺼가 실행된 상태에서 등록한 것인지, 남아있는 상태에서 등록된 것인지 알 수 없지만, sync는 2가 등록될 시점에는 1은 반드시 끝나있고 3이 등록될 시점에는 2는 반드시 끝나있음
    serialQueue.async { self.log("1") }
    log("A")
    serialQueue.async { self.log("2") }
    log("B")
    serialQueue.async { self.log("3") }
    log("C")
    print()
  }
  
  @IBAction private func concurrentSyncOrder(_ sender: UIButton) {
    print("\n---------- [ Concurrent Sync ] ----------\n")
    let concurrentQueue = DispatchQueue(
      label: "kr.giftbot.concurrentQueue",
      attributes: [.concurrent]
    )
    // 순서 : 1a2b3c
    // sync 방식은 serial, concurrent에 상관 없이 호출한 작업이 끝나야 다음으로 넘어감. Concurrent라도 1이 완전이 끝난 다음에 A로 넘어갈 수 있다
    
    concurrentQueue.sync { log("1") }
    log("A")
    concurrentQueue.sync { log("2") }
    log("B")
    concurrentQueue.sync { log("3") }
    log("C")
    print()
    
    
    // sync : 호출한 작업이 끝나야 다음으로 넘어감
    // 동작하는 과정, 순서,? 조건?을 이해
  }
  
  @IBAction private func concurrentAsyncOrder(_ sender: UIButton) {
    print("\n---------- [ Concurrent Async ] ----------\n")
    let concurrentQueue = DispatchQueue(
      label: "kr.giftbot.concurrentQueue",
      attributes: [.concurrent]
    )
    // ABCD 고정, 1234 랜덤
    // concurrent queue이므로 먼저 등록된 작업은 상대적으로 빨리 실행될 가능성이 높은 것일 뿐. 1234 작업이 queue에 등록되는 순서와 상관없이 실행되는 순서는 보장되지 않음
    // async이므로 1234 작업이 끝나지 않아도 다음으로 넘어감
    
    concurrentQueue.async { self.log("1") }
//    concurrentQueue.async(qos: .userInteractive, execute: { self.log("1") })
    log("A")
    concurrentQueue.async { self.log("2") }
    log("B")
    concurrentQueue.async { self.log("3") }
    log("C")
//    concurrentQueue.async { self.log("4") }
//    log("D")
    print()
  }
  
  
  
  private func createDispatchWorkItem() -> DispatchWorkItem {
    // 출력 순서
    // 25%, 50% , 75%, 100%
    let workItem = DispatchWorkItem {
      let bigNumber = 8_000_000
      let divideNumber = 2_000_000
      for i in 1...bigNumber {
        guard i % divideNumber == 0 else { continue }
        print(i / divideNumber * 25, "%")
      }
    }
    return workItem
  }
  
  
  @IBAction func waitWorkItem() {
    print("\n---------- [ waitWorkItem ] ----------\n")
    
    let workItem = createDispatchWorkItem()
    let myQueue = DispatchQueue(label: "kr.giftbot.myQueue")
    
    // async vs sync
    myQueue.async(execute: workItem)
//    myQueue.sync(execute: workItem)
    
    print("before waiting")
//    workItem.wait()   // before 실행 후 work 후 after. async를 원하는 시점에 sync처럼 동작시켜 주는 것. 실행이 완료될 때 까지 대기
    print("after waiting")
  }
  
  
  let inactiveQueue = DispatchQueue(
    label: "kr.giftbot.inactiveQueue",
    attributes: [.initiallyInactive, .concurrent]
  )
  // initiallyInactive : Inactive 상태로 초기화함. 생성.
  
  @IBAction func initiallyInactiveQueue() {
    print("\n---------- [ initiallyInactiveQueue ] ----------\n")

    let workItem = createDispatchWorkItem()
    inactiveQueue.async(execute: workItem)
    // 처음에 활성화 된 상태가 아님
    
    print("= Do Something... =")
    
    // 필요한 타이밍에 activate 메서드를 통해 활성화
    inactiveQueue.activate()
    // 여러번 실행해도 한 번만 실행됨
    // activate는 queue에서 작업을 빼서 실행하는 것이므로
    // 최초 1번 작업을 빼서 실행하고 나면 뒤에는 없으므로 실행되지 않음
  }
  
  
  @IBAction func groupNotify() {
    print("\n---------- [ groupNotify ] ----------\n")
    
    let queue1 = DispatchQueue(label: "kr.giftbot.example.queue1",
                               attributes: .concurrent)
    let queue2 = DispatchQueue(label: "kr.giftbot.example.queue2")
    
    func calculate(task: Int, limit: Int) {
      print("Task\(task) 시작")
      for _ in 0...limit { _ = 1 + 1 }
      print("Task\(task) 종료")
    }
    
//    queue1.async { calculate(task: 1, limit: 12_000_000) }
//    queue1.async { calculate(task: 2, limit:  5_000_000) }
//    queue2.async { calculate(task: 3, limit:  2_000_000) }
//    print("The End")
    
    let group = DispatchGroup()
    queue1.async(group: group) { calculate(task: 1, limit: 12_000_000) }
    queue1.async(group: group) { calculate(task: 2, limit:  5_000_000) }
    queue2.async(group: group) { calculate(task: 3, limit:  2_000_000) }
    group.notify(queue: .main) { print("The End") }
  }
  
  
  var myWorkItem: DispatchWorkItem!
  
  @IBAction func cancelDispatchWorkItem() {
    myWorkItem = DispatchWorkItem {
      let bigNumber = 8_000_000
      let divideNumber = bigNumber / 4
      for i in 1...bigNumber {
        guard i % divideNumber == 0 else { continue }
        guard !self.myWorkItem.isCancelled else { return }
        print(i / divideNumber * 25, "%")
      }
    }

    DispatchQueue.global().async(execute: myWorkItem)
    
    // 3초 안에 실행되지 않으면 취소
    let timeLimit = 3.0
    DispatchQueue.global().async {
      let timeoutResult = self.myWorkItem.wait(timeout: .now() + timeLimit)
      switch timeoutResult {
      case .success:    print("Success within \(timeLimit) seconds")
      case .timedOut:
        self.myWorkItem.cancel()  // workItem의 isCancelled 속성을 true로 바꿈. 작업할 때 해당 속성을 check해서 작업을 끝내야함
        print("Timeout")
      }
    }
  }
}
