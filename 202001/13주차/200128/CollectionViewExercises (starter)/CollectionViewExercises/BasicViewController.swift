//
//  BasicViewController.swift
//  CollectionViewExercises
//
//  Created by Giftbot on 2020/01/28.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import UIKit

final class BasicViewController: UIViewController {
  
  let dataSource = cards
  var collectionView: UICollectionView!
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupCollectionView()
  }
  
  func setupCollectionView() {
    let layout = UICollectionViewFlowLayout()
    layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    layout.minimumLineSpacing = 4
    layout.minimumInteritemSpacing = 4
    layout.itemSize = CGSize(width: 80, height: 160)
    
    self.collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
    self.collectionView.backgroundColor = .white
    self.collectionView.dataSource = self
    self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "ColorCard")
    self.view.addSubview(self.collectionView)
  }
}

// MARK: - UICollectionViewDataSource

extension BasicViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return dataSource.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCard", for: indexPath)
    cell.backgroundColor = dataSource[indexPath.item].color
    return cell
  }
}
