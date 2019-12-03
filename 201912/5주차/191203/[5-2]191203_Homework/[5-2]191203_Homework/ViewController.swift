//
//  ViewController.swift
//  [5-2]191203_Homework
//
//  Created by cskim on 2019/12/03.
//  Copyright © 2019 cskim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK:- Outlets
    
    @IBOutlet private weak var dogButton: UIButton!
    @IBOutlet private weak var catButton: UIButton!
    @IBOutlet private weak var birdButton: UIButton!
    @IBOutlet private weak var countLabel: UILabel!

    // MARK:- ID and Counts
    
    enum Animal: Int {
        case Dog, Cat, Bird
    }
    
    let IDdict: [Animal: String] = [
        Animal.Dog: "Dog",
        Animal.Cat: "Cat",
        Animal.Bird: "Bird"
    ]
    
    var counts: [(Int, Int)] = [
        (0, 8),
        (0, 10),
        (0, 15)] {
        didSet{
            countLabel.text = "(\(counts[0].0), \(counts[1].0), \(counts[2].0))"
        }
    }
    
    // MARK:- Action Segue
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        super.shouldPerformSegue(withIdentifier: identifier, sender: sender)
        
        for ID in IDdict {
            if identifier == ID.value {
                let count = counts[ID.key.rawValue]
                return count.0 != count.1
            }
        }
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let secondVC = segue.destination as? SecondViewController else { return }
        guard let sender = sender as? UIButton else { return }
        guard let animal = Animal(rawValue: sender.tag), let name = IDdict[animal] else { return }
        
        secondVC.name = name
        counts[sender.tag].0 += 1
    }
    
    
    // MARK:- Unwind Segue
    
    @IBAction func unwindToFirstVC(_ unwindSegue: UIStoryboardSegue) {
        guard let secondVC = unwindSegue.source as? SecondViewController else { return }
        
        let add = secondVC.count
        for index in 0..<3 {
            counts[index].0 = min(counts[index].0 + add, counts[index].1)
        }
    }
}

