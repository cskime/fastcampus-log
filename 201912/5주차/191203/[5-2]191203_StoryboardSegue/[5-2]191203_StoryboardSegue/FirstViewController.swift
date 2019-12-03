//
//  FirstViewController.swift
//  [5-2]191203_StoryboardSegue
//
//  Created by cskim on 2019/12/03.
//  Copyright © 2019 cskim. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    var presentCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        label.text = "Count : \(presentCount)"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let secondVC = segue.destination as? SecondViewController else { return }
        
        presentCount += 1
        
        if segue.identifier == "FullScreenSegue" {
            secondVC.text = "Count : \(presentCount)"
        } else if segue.identifier == "CardStyleSegue" {
            secondVC.text = "Count : \(presentCount)"
        }
    }
    
    var total = 0
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        super.shouldPerformSegue(withIdentifier: identifier, sender: sender)
        total = identifier == "FullScreenSegue" ? total + 10 : total + 1
        totalLabel.text = "Total: \(total)"
        return true
    }
    
    @IBAction private func didTapFivePlus(_ sender: UIButton) {
        performSegue(withIdentifier: "PlusFive", sender: sender)
    }
    
    
    @IBAction func unwindToFirstVC(_ unwindSegue: UIStoryboardSegue) {
        // Use data from the view controller which initiated the unwind segue
        
        guard let secondVC = unwindSegue.source as? SecondViewController else { return }
        
        presentCount = presentCount - secondVC.minus
        label.text = "Count : \(presentCount)"
    }
}
