//
//  FlexibleViewController.swift
//  CollectionViewExample
//
//  Created by giftbot on 2020/01/24.
//  Copyright © 2020 giftbot. All rights reserved.
//

import UIKit

final class FlexibleViewController: UIViewController {
  
  let layout = UICollectionViewFlowLayout()
  lazy var collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
  var parkImages = ParkManager.imageNames(of: .nationalPark)
  
  
  // MARK: - View Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupCollectionView()
  }
  
  // MARK: Setup CollectionView
  
  func setupCollectionView() {
    self.setupFlowLayout()
    self.collectionView.register(CustomCell.self, forCellWithReuseIdentifier: CustomCell.identifier)
    self.collectionView.backgroundColor = .white
    self.collectionView.dataSource = self
    self.view.addSubview(self.collectionView)
  }
  
  func setupFlowLayout() {
    // 세로 방향 스크롤 기준
    let itemsInLine: CGFloat = 3  // line당 item 개수
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
}


// MARK: - UICollectionViewDataSource

extension FlexibleViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return parkImages.count * 5
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: CustomCell.identifier, for: indexPath
      ) as! CustomCell
    cell.backgroundColor = .black

    let item = indexPath.item % self.parkImages.count
    cell.configure(image: UIImage(named: parkImages[item]), title: parkImages[item])
    
    
    return cell
  }
}



