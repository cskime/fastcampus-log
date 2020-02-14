//
//  ProductCell.swift
//  DominoStarter
//
//  Created by cskim on 2019/12/27.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {

    static let identifier = String(describing: ProductCell.self)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Interface
    
    func updateContent(with product: Product) {
        self.textLabel?.text = product.name
        self.detailTextLabel?.text = "\(product.price) 원"
        self.imageView?.image = UIImage(named: product.thumbnail)
    }
}
