//
//  ViewController.swift
//  CollectionViewPractice
//
//  Created by Giftbot on 2020/01/28.
//  Copyright © 2020 Giftbot. All rights reserved.
//

/*
 [ 과제 ]
 > 10장의 이미지를 x 2 해서 20개 아이템으로 만들어 콜렉션뷰에 표시 (세로 방향 스크롤)
 > 각 아이템을 선택했을 때 체크 아이콘 표시 (체크 이미지 : SF Symbol - checkmark.circle.fill)
   + 선택되어 있는 느낌이 나도록 별도 효과 주기 (영상 참고, 효과는 변경 가능)
 > 삭제 버튼을 눌렀을 때 체크표시 되어 있는 아이템들을 삭제
 > 20개의 아이템이 모두 삭제되었을 경우는 다시 반복할 수 있도록 처음 20개 상태로 복구
 > 손가락 2개로 터치 후 드래그했을 때 아이템이 다중 선택/해제될 수 있도록 구현  (이 기능은 샘플 영상에 없음)
 > 한 라인에 지정된 개수만큼의 아이템이 나타나도록 처리 (4를 지정하면 한 라인에 4개의 아이템 출력)
 [ 과제 관련 힌트 ]
 > allowsMultipleSelection 프로퍼티
 > deleteItems, insertItems 메서드
 > UICollectionViewDelegate - shouldBeginMultipleSelectionInteractionAt
 > 아이템 선택에 관련된 처리 방법 (다음 3가지 중 하나를 이용해서 처리 가능)
 1. isSelected 프로퍼티
 2. UICollectionViewDelegate의 didSelect/didDeselect 메서드 사용
 3. selectedBackgroundView 프로퍼티
 */


import UIKit

class ViewController: UIViewController {
  
  private var collectionView: UICollectionView!
  private var origin = [String]()
  private var cats = [String]()
//  private var selectedIndex = Set<IndexPath>()
  
  // MARK: LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupUI()
  }
  
  private func setupUI() {
    (0...9).forEach { self.origin.append("cat\($0)") }
    self.cats = self.origin + self.origin
    self.setupCollectionView()
    self.setupConstraints()
  }
  
  private let numberOfItems = 2
  private let inset: CGFloat = 8
  private let lineSpacing: CGFloat = 8
  private let itemSpacing: CGFloat = 16
  private var itemSize: CGFloat {
    get { (self.view.frame.width - self.inset * 2 - self.itemSpacing * CGFloat(self.numberOfItems - 1)) / CGFloat(self.numberOfItems) }
  }
  
  private func setupCollectionView() {
    let layout = UICollectionViewFlowLayout()
    layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    layout.minimumInteritemSpacing = 16
    layout.minimumLineSpacing = 8
    layout.itemSize = CGSize(width: self.itemSize, height: self.itemSize)
    
    self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    self.collectionView.register(CustomCell.self, forCellWithReuseIdentifier: CustomCell.identifier)
    self.collectionView.backgroundColor = .white
    self.collectionView.dataSource = self
    self.collectionView.delegate = self
    self.collectionView.allowsMultipleSelection = true
  
  }
  
  private func setupConstraints() {
    self.view.addSubview(self.collectionView)
    let guide = self.view.safeAreaLayoutGuide
    self.collectionView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      self.collectionView.topAnchor.constraint(equalTo: guide.topAnchor),
      self.collectionView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
      self.collectionView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
      self.collectionView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
    ])
  }
  
  // MARK: Action
  
  private var isEditMode = false
  @IBAction private func deleteTouched(_ sender: UIBarButtonItem) {
    if self.isEditMode { self.deleteImages() }
    self.isEditMode.toggle()
  }
  
  // MARK: Methods
  
  private func deleteImages() {
    guard let selectedIndices = self.collectionView.indexPathsForSelectedItems else { return }
    print(selectedIndices)

    selectedIndices
      .sorted { $0.item > $1.item }
      .forEach { self.cats.remove(at: $0.item) }
    if self.cats.isEmpty {
      self.cats = self.origin + self.origin
      self.collectionView.reloadData()
    } else {
      self.collectionView.deleteItems(at: selectedIndices)
    }
  }

}


// MARK: - UICollectionViewDataSource

extension ViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return cats.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCell.identifier, for: indexPath) as! CustomCell
    cell.configureContents(image: UIImage(named: self.cats[indexPath.item]))
    return cell as UICollectionViewCell
  }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
  // Select Cell
  func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
    return self.isEditMode
  }
  
//  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//    print("Did Select")
//    self.selectedIndex.insert(indexPath)
//  }
//  
//  func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//    print("Did Deselect")
//    self.selectedIndex.remove(indexPath)
//  }
  
  // Drag해서 multiple selection
  func collectionView(_ collectionView: UICollectionView, shouldBeginMultipleSelectionInteractionAt indexPath: IndexPath) -> Bool {
    print("Multiple Selection Should Begin")
    return true
  }
}
