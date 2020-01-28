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
   
   // MARK: Setup CollectionView
   
   func setupCollectionView() {
     
   }
   
   func setupFlowLayout() {
     
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
    return cell
  }
}



