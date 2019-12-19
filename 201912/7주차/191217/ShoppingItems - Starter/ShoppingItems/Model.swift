//
//  Model.swift
//  ShoppingItems
//
//  Created by cskim on 2019/12/19.
//  Copyright © 2019 giftbot. All rights reserved.
//

import UIKit

class ItemInfo {
    static let shared = ItemInfo()
    
    private let devices = [
        "iPhoneSE_Gold",
        "iPhoneSE_RoseGold",
        "iPhone8",
        "iPhoneX_White",
        "iPhoneX_SpaceGray"
    ]
    
    private var titles = [String]()
    private var counts = [Int]()
    private var limits = [Int]()
    var numberOfItems: Int
    
    private init() {
        for index in 0..<devices.count * 3 {
            titles.append(devices[index % 5] + " \(index / 5)")
            counts.append(0)
        }
        
        while limits.count < counts.count {
            let random = (1...20).randomElement() ?? 0
            limits.append(random)
        }
        
        numberOfItems = titles.count
    }
    
    func itemName(at index: Int) -> String {
        return titles[index]
    }
    
    func itemCount(at index: Int) -> Int {
        return counts[index]
    }
    
    func updateCount(_ count: Int, at index: Int) -> Bool {
        guard count <= limits[index] else {
            return false
        }
        counts[index] = count
        return true
    }
    
    func itemImage(at index: Int) -> UIImage {
        return UIImage(named: devices[index % 5])!
    }
}
