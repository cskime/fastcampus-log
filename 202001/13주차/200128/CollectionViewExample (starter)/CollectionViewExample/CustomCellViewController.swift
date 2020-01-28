//
//  BasicCodeViewController.swift
//  CollectionViewExample
//
//  Created by giftbot on 2020/01/24.
//  Copyright © 2020 giftbot. All rights reserved.
//

import UIKit

final class CustomCellViewController: UIViewController {
  
  let flowLayout = UICollectionViewFlowLayout()
  lazy var collectionView = UICollectionView(
    frame: view.frame, collectionViewLayout: flowLayout
  )
  
  let itemCount = 120
  let parkImages = ParkManager.imageNames(of: .nationalPark)
  var showsImage = false
  
  // MARK: LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupCollectionView()
    setupNavigationItem()
  }

  // MARK: Setup Views
  
  private func setupCollectionView() {
    setupFlowLayout()
    
    self.collectionView.backgroundColor = .white
    self.collectionView.allowsSelection = true
    self.collectionView.dataSource = self
    self.collectionView.delegate = self
    self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "ColorCircle")
    self.collectionView.register(CustomCell.self, forCellWithReuseIdentifier: CustomCell.identifier)
    self.view.addSubview(self.collectionView)
  }
  
  private func setupFlowLayout() {
    if showsImage {
      self.flowLayout.itemSize = CGSize(width: 120, height: 120)
      self.flowLayout.minimumInteritemSpacing = 15
      self.flowLayout.minimumLineSpacing = 15
      self.flowLayout.sectionInset = .init(top: 10, left: 10, bottom: 10, right: 10)
    } else {
      self.flowLayout.itemSize = CGSize(width: 60, height: 60)
      self.flowLayout.minimumInteritemSpacing = 10
      self.flowLayout.minimumLineSpacing = 20
      self.flowLayout.sectionInset = .init(top: 5, left: 5, bottom: 5, right: 5)
    }
  }
  
  private func setupNavigationItem() {
    let changeItem = UIBarButtonItem(
      barButtonSystemItem: .refresh,
      target: self,
      action: #selector(changeCollectionViewItems(_:))
    )
    let changeDirection = UIBarButtonItem(
      barButtonSystemItem: .reply,
      target: self,
      action: #selector(changeCollectionViewDirection(_:))
    )
    navigationItem.rightBarButtonItems = [changeItem, changeDirection]
  }
  
  // MARK: Action
  
  @objc private func changeCollectionViewItems(_ sender: Any) {
    showsImage.toggle()
    setupFlowLayout()
    collectionView.reloadData()
  }
  
  @objc private func changeCollectionViewDirection(_ sender: Any) {
    let direction = flowLayout.scrollDirection
    flowLayout.scrollDirection = direction == .horizontal ? .vertical : .horizontal
  }
  
  // MARK: Methods
  func color(at indexPath: IndexPath) -> UIColor {
    let max = itemCount
    let currentIndex = CGFloat(indexPath.item)
    let factor = 0.1 + (currentIndex / CGFloat(max)) * 0.8  // 0.1 ~ 0.9 사이값이 나오도록
    if showsImage {
      return .init(hue: factor, saturation: 1, brightness: 1, alpha: 1)
    } else {
      return .init(hue: factor, saturation: factor, brightness: 1, alpha: 1)
    }
    
  }
 
}

// MARK: - UICollectionViewDataSource

extension CustomCellViewController: UICollectionViewDataSource {

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return itemCount
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: UICollectionViewCell!
    if showsImage {
      let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCell.identifier, for: indexPath) as! CustomCell
      let item = indexPath.item % parkImages.count
      let park = parkImages[item]
      customCell.configure(image: UIImage(named: park), title: park)
      cell = customCell
    } else {
      cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCircle", for: indexPath)
      cell.layer.cornerRadius = cell.frame.width / 2
    }
    
    cell.backgroundColor = self.color(at: indexPath)
    return cell
  }
}

// MARK:- UICollectionViewDelegateFlowLayout

extension CustomCellViewController: UICollectionViewDelegateFlowLayout {
  
  // UICollectionViewDelegate에 있는 method
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    cell.alpha = 0
    cell.transform = .init(scaleX: 0.3, y: 0.3)
    
    UIView.animate(withDuration: 0.3) {
      cell.alpha = 1
      cell.transform = .identity
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
    if indexPath.item % 5 == 2 {
      return flowLayout.itemSize.applying(.init(scaleX: 2, y: 2))
    } else {
      return flowLayout.itemSize
    }
  }
}
