//
//  SupplementaryViewController.swift
//  CollectionViewExercises
//
//  Created by Giftbot on 2020/01/28.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import UIKit

final class SupplementaryViewController: UIViewController {
  
  var dataSource: [Section] = sections
  private let flowLayout: UICollectionViewFlowLayout = {
    // 셀 크기 = (80, 80) / 아이템과 라인 간격 = 4 / 인셋 = (25, 5, 25, 5)
    // 헤더 높이 50, 푸터 높이 3
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(width: 80, height: 80)
    layout.minimumInteritemSpacing = 4
    layout.minimumLineSpacing = 4
    layout.sectionInset = .init(top: 25, left: 5, bottom: 25, right: 5)
    layout.headerReferenceSize = CGSize(width: 0, height: 50)
    layout.sectionHeadersPinToVisibleBounds = true
    layout.footerReferenceSize = CGSize(width: 0, height: 3)
    return layout
  }()
  private lazy var collectionView: UICollectionView = {
    let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: self.flowLayout)
    collectionView.backgroundColor = .white
    collectionView.dataSource = self
    collectionView.register(
      UICollectionViewCell.self,
      forCellWithReuseIdentifier: "CardCell"
    )
    collectionView.register(
      SectionHeaderView.self,
      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
      withReuseIdentifier: SectionHeaderView.identifier)
    collectionView.register(
      UICollectionReusableView.self,
      forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
      withReuseIdentifier: "DividerView")
    return collectionView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupCollectionView()
    self.setupGestureRecognizer()
  }
  
  private func setupCollectionView() {
    self.view.addSubview(self.collectionView)
  }
  
  private func setupGestureRecognizer() {
    let gesture = UILongPressGestureRecognizer(target: self, action: #selector(gestureHandler(_:)))
    self.collectionView.addGestureRecognizer(gesture)
  }
  
  // MARK: Actions
  @objc private func gestureHandler(_ sender: UILongPressGestureRecognizer) {
    let location = sender.location(in: self.collectionView)
    switch sender.state {
    case .began:
      guard let indexPath = self.collectionView.indexPathForItem(at: location) else { return }
      self.collectionView.beginInteractiveMovementForItem(at: indexPath)
    case .changed:
      self.collectionView.updateInteractiveMovementTargetPosition(location)
    case .cancelled:
      self.collectionView.cancelInteractiveMovement()
    case .ended:
      self.collectionView.endInteractiveMovement()
    default:
      return
    }
  }
}


// MARK: - UICollectionViewDataSource

extension SupplementaryViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return dataSource.count
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return dataSource[section].cards.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath)
    cell.backgroundColor = dataSource[indexPath.section].cards[indexPath.item].color
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    if kind == UICollectionView.elementKindSectionHeader {
      guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.identifier, for: indexPath) as? SectionHeaderView else { return UICollectionReusableView() }
      header.configure(title: "Section \(indexPath.section)")
      return header
    } else {
      let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "DividerView", for: indexPath)
      footer.backgroundColor = .darkGray
      return footer
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    guard sourceIndexPath != destinationIndexPath else { return }
    
    let target = dataSource[sourceIndexPath.section].cards.remove(at: sourceIndexPath.item)
    dataSource[destinationIndexPath.section].cards.insert(target, at: destinationIndexPath.item)
  }
}
