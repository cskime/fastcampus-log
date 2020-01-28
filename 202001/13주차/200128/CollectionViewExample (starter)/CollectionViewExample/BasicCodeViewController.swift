//
//  BasicCodeViewController.swift
//  CollectionViewExample
//
//  Created by Giftbot on 2020/01/28.
//  Copyright © 2020 giftbot. All rights reserved.
//

import UIKit

final class BasicCodeViewController: UIViewController {
  
  let itemCount = 100
  var collectionView: UICollectionView!
  
  // MARK: LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupSliders()
    setupCollectionView()
    setupNavigationItem()
  }

  // MARK: Setup Views
  
  func setupSliders() {
    let sizeSlider = UISlider()
    sizeSlider.minimumValue = 10
    sizeSlider.maximumValue = 200
    sizeSlider.value = 50
    
    let spacingSlider = UISlider()
    spacingSlider.minimumValue = 0
    spacingSlider.maximumValue = 50
    spacingSlider.value = 10
    spacingSlider.tag = 1
    
    let edgeSlider = UISlider()
    edgeSlider.minimumValue = 0
    edgeSlider.maximumValue = 50
    edgeSlider.value = 10
    edgeSlider.tag = 2
    
    let sliders = [sizeSlider, spacingSlider, edgeSlider]
    sliders.forEach { $0.addTarget(self, action: #selector(editLayout(_:)), for: .valueChanged) }
    
    let stackView = UIStackView(arrangedSubviews: sliders)
    self.view.addSubview(stackView)
    stackView.axis = .vertical
    stackView.alignment = .fill
    stackView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
      stackView.widthAnchor.constraint(equalToConstant: 300),
    ])
  }
  
  func setupCollectionView() {
    let layout = UICollectionViewFlowLayout()
    layout.minimumInteritemSpacing = 10 // 기본값 10
    layout.minimumLineSpacing = 10      // 기본값 10
    layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)  // 기본값 .zero
    layout.itemSize = CGSize(width: 60, height: 60) // 기본값 50, 50
    // offsetBy : CGRect 값에서 dx, dy만큼 떨어진 지점에서의 영역 반환
    self.collectionView = UICollectionView(frame: view.frame.offsetBy(dx: 0, dy: 250), collectionViewLayout: layout)
    self.collectionView.backgroundColor = .white  // 기본값 .black
    self.collectionView.dataSource = self
    self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "ColorCircle")
    self.view.addSubview(self.collectionView)
  }
  
  func setupNavigationItem() {
    let changeDirectionButton = UIBarButtonItem(barButtonSystemItem: .reply, target: self, action: #selector(changeCollectionViewDirection(_:)))
    self.navigationItem.rightBarButtonItem = changeDirectionButton
  }
  
  
  // MARK: Action
  
  @objc private func editLayout(_ sender: UISlider) {
    let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
    let value = CGFloat(sender.value)
    switch sender.tag {
    case 0: layout.itemSize = CGSize(width: value, height: value)
    case 1:
      layout.minimumInteritemSpacing = value
      layout.minimumLineSpacing = value
    case 2:
      layout.sectionInset = UIEdgeInsets(top: value, left: value, bottom: value, right: value)
    default:
      return
    }
  }
  
  @objc private func changeCollectionViewDirection(_ sender: Any) {
    let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
    let currentDirection = layout.scrollDirection
    layout.scrollDirection = currentDirection == .horizontal ? .vertical : .horizontal
  }
}


// MARK: - UICollectionViewDataSource

extension BasicCodeViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return itemCount
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCircle", for: indexPath)
    cell.backgroundColor = [.red, .green, .blue, .magenta, .gray, .cyan, .orange].randomElement()
    return cell
  }
}
