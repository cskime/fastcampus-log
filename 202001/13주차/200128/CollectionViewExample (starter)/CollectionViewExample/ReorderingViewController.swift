//
//  ReorderingViewController.swift
//  CollectionViewExample
//
//  Created by Giftbot on 2020/01/28.
//  Copyright © 2020 giftbot. All rights reserved.
//

import UIKit

final class ReorderingViewController: UIViewController {

  var parkImages = ParkManager.imageNames(of: .nationalPark)
  
  let layout = UICollectionViewFlowLayout()
  lazy var collectionView: UICollectionView = {
    let cv = UICollectionView(frame: view.frame, collectionViewLayout: layout)
    cv.register(CustomCell.self, forCellWithReuseIdentifier: CustomCell.identifier)
    cv.backgroundColor = .white
    cv.dataSource = self
    self.view.addSubview(cv)
    return cv
  }()
  
  // MARK: - View Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    setupFlowLayout()
    setupLongPressGestureRecognizer()
  }


  // MARK: Setup FlowLayout

  func setupFlowLayout() {
    // 세로 방향 스크롤 기준
    let itemsInLine: CGFloat = 4  // line당 item 개수
    let spacing: CGFloat = 10
    let insets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    let collectionViewWidth = self.collectionView.bounds.width
    let contentSize = (collectionViewWidth - insets.left - insets.right - (spacing * (itemsInLine - 1)))
    let itemSize = (contentSize / itemsInLine).rounded(.down) // 소수점 버리기
    
    self.layout.minimumLineSpacing = spacing
    self.layout.minimumInteritemSpacing = spacing
    self.layout.sectionInset = insets
    self.layout.itemSize = CGSize(width: itemSize, height: itemSize)
  }

  // MARK: Setup Gesture
  
  func setupLongPressGestureRecognizer() {
    let gesture = UILongPressGestureRecognizer(
      target: self,
      action: #selector(reorderCollectionViewItem(_:))
    )
    collectionView.addGestureRecognizer(gesture)
  }
  
  
  // MARK: - Action

  @objc private func reorderCollectionViewItem(_ sender: UILongPressGestureRecognizer) {
    let location = sender.location(in: collectionView)
    switch sender.state {
    case .began:
      guard let indexPath = collectionView.indexPathForItem(at: location) else { break }
      collectionView.beginInteractiveMovementForItem(at: indexPath)
    case .changed:
      collectionView.updateInteractiveMovementTargetPosition(location)
    case .cancelled:
      collectionView.cancelInteractiveMovement()
    case .ended:
      collectionView.endInteractiveMovement()
    default:
      break
    }
  }
}

// MARK: - UICollectionViewDataSource

extension ReorderingViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return parkImages.count * 3
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: CustomCell.identifier, for: indexPath
      ) as! CustomCell
    cell.backgroundColor = .black
    let item = indexPath.item % parkImages.count
    cell.configure(image: UIImage(named: parkImages[item]), title: parkImages[item])
    return cell
  }
  
  // beginInteractiveMovementForItem 실행될 때 호출됨
  func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
    print("Can Move Item")
    return true
  }
  
  // item 끌고 움직이다가 놓는 순간 호출됨
  func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    guard sourceIndexPath != destinationIndexPath else { return }
    let source = sourceIndexPath.item % parkImages.count
    let destination = destinationIndexPath.item % parkImages.count
    print("source :", source, "dest :", destination)
    
    // 1. 없애고
    let element = parkImages.remove(at: source)
    
    // 2. 목적지에 다시 추가
    parkImages.insert(element, at: destination)
    
    // Long Press Geustre 실행했을 때
    // beginInteractiveMovementForItem 등에서 UI 작업을 할 것이라고 알고 있기 떄문에
    // reloadData나 cell delete/insert 등의 UI 작업을 별도로 하지 않고
    // 데이터만 추가하면 된다.
    
  }
}


