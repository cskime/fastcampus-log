//
//  FitItemsViewController.swift
//  CollectionViewExample
//
//  Created by Giftbot on 2020/01/28.
//  Copyright © 2020 giftbot. All rights reserved.
//

import UIKit

class FitItemsViewController: UIViewController {
  
  private enum UI {
    static let itemsInLine: CGFloat = 2
    static let linesOnScreen: CGFloat = 2
    static let itemSpacing: CGFloat = 10.0
    static let lineSpacing: CGFloat = 10.0
    static let edgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
  }
  
  let layout = UICollectionViewFlowLayout()
  lazy var collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
  var parkImages = ParkManager.imageNames(of: .nationalPark)
  
  
  // MARK: LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupCollectionView()
    setupNavigationItem()
  }
  
//  override func viewSafeAreaInsetsDidChange() {
//    super.viewSafeAreaInsetsDidChange()
//    self.setupFlowLayout()
//  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    self.setupFlowLayout()  // safeAreaInset을 위해
  }
  
  // MARK: Setup CollectionView
  
  func setupCollectionView() {
    collectionView.register(CustomCell.self, forCellWithReuseIdentifier: CustomCell.identifier)
    collectionView.backgroundColor = .white
    collectionView.dataSource = self
    self.view.addSubview(collectionView)
  }
  
  func setupFlowLayout() {
    self.layout.minimumInteritemSpacing = UI.itemSpacing
    self.layout.minimumLineSpacing = UI.lineSpacing
    self.layout.sectionInset = UI.edgeInsets
    
    self.fitItemsAndLinesOnScreen()
  }
  
  func fitItemsAndLinesOnScreen() {
    let itemSpacing = UI.itemSpacing * (UI.itemsInLine - 1) // 전체 item spacing
    let lineSpacing = UI.lineSpacing * (UI.linesOnScreen - 1) // 전체 lineSpacing
    let horizontalInset = UI.edgeInsets.left + UI.edgeInsets.right
    let verticalInset = UI.edgeInsets.top + UI.edgeInsets.bottom + self.view.safeAreaInsets.top + self.view.safeAreaInsets.bottom
    
    let isVertical = layout.scrollDirection == .vertical
    let horizontalSpacing = (isVertical ? itemSpacing : lineSpacing) + horizontalInset
    let verticalSpacing = (isVertical ? lineSpacing : itemSpacing) + verticalInset
    
    let contentWidth = collectionView.frame.width - horizontalSpacing
    let contentHeight = collectionView.frame.height - verticalSpacing
    let width = contentWidth / (isVertical ? UI.itemsInLine : UI.linesOnScreen)
    let height = contentHeight / (isVertical ? UI.linesOnScreen : UI.itemsInLine)
    
    layout.itemSize = CGSize(
      width: width.rounded(.down),
      height: height.rounded(.down)
    )
  }
  
  
  // MARK: Setup NavigationItem
  
  func setupNavigationItem() {
    let changeDirection = UIBarButtonItem(
      barButtonSystemItem: .reply,
      target: self,
      action: #selector(changeCollectionViewDirection(_:))
    )
    navigationItem.rightBarButtonItems = [changeDirection]
  }
  
  // MARK: - Action
  
  @objc private func changeCollectionViewDirection(_ sender: Any) {
    let direction = layout.scrollDirection
    layout.scrollDirection = direction == .horizontal ? .vertical : .horizontal
    self.setupFlowLayout()
  }
}


// MARK: - UICollectionViewDataSource

extension FitItemsViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return parkImages.count * 5
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: CustomCell.identifier,
      for: indexPath
      ) as! CustomCell
    cell.backgroundColor = .black
    
    let item = indexPath.item % parkImages.count
    cell.configure(image: UIImage(named: parkImages[item]), title: parkImages[item])
    
    return cell
  }
}



