//
//  ItemCell.swift
//  ShoppingItems
//
//  Created by giftbot on 2019. 12. 17..
//  Copyright © 2019년 giftbot. All rights reserved.
//

import UIKit

final class ItemCell: UITableViewCell {
  
    static let identifier = "ItemCell"
    
    var incrementButton = UIButton(type: .custom)
    var countLabel = UILabel()
    var imgView = UIImageView()
    var nameLabel = UILabel()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    var count = 0 {
        didSet {
            countLabel.text = "\(count)"
        }
    }
    
    private func setupUI() {
        contentView.addSubview(incrementButton)
        incrementButton.setImage(UIImage(named: "add"), for: .normal)
        incrementButton.addTarget(self, action: #selector(increment(_:)), for: .touchUpInside)
        
        contentView.addSubview(countLabel)
        countLabel.font = .systemFont(ofSize: 20)
        
        contentView.addSubview(imgView)
        imgView.contentMode = .scaleAspectFit
        
        contentView.addSubview(nameLabel)
        nameLabel.font = .systemFont(ofSize: 20)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        imgView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imgView.heightAnchor.constraint(equalToConstant: 48),
            imgView.widthAnchor.constraint(equalTo: imgView.heightAnchor),
            imgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            imgView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: 10),
            nameLabel.centerYAnchor.constraint(equalTo: imgView.centerYAnchor),
        ])
        
        
        incrementButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            incrementButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            incrementButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            incrementButton.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: -50),
            incrementButton.widthAnchor.constraint(equalTo: incrementButton.heightAnchor, multiplier: 1.0),
        ])
        
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            countLabel.centerYAnchor.constraint(equalTo: incrementButton.centerYAnchor),
            countLabel.trailingAnchor.constraint(equalTo: incrementButton.leadingAnchor, constant: -16)
        ])
    }
    
    func updateName(_ name: String) {
        nameLabel.text = name
    }
    
    func updateImage(_ image: UIImage) {
        imgView.image = image
    }
    
    var currentRow = 0
    func updateCount(_ count: Int, at index: Int) {
        self.count = count
        currentRow = index
    }
    
    @objc private func increment(_ sender: UIButton) {
        let currentCount = ItemInfo.shared.itemCount(at: currentRow)
        let canUpdated = ItemInfo.shared.updateCount(currentCount + 1, at: currentRow)
        
        if canUpdated {
            count = currentCount + 1
        } else {
            contentView.backgroundColor = UIColor.red.withAlphaComponent(0.5)
            UIView.animate(withDuration: 0.7) {
                self.contentView.backgroundColor = nil
            }
        }
    }
    
}
