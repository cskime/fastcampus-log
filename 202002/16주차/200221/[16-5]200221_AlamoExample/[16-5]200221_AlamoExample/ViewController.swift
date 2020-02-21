//
//  ViewController.swift
//  [16-5]200221_AlamoExample
//
//  Created by cskim on 2020/02/21.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  private var users = [User]() {
    didSet { self.tableView.reloadData() }
  }
  private let serviceManager = ServiceManager.shared
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.rowHeight = 60
    // AF에 요청하고, 그 결과로 뭘 할것인지 VC가 정하도록 한 것
    serviceManager.requestUser { [weak self] (result) in
      switch result {
      // requestUser에서 response.result가 success일 때
      case .success(let users):   self?.users = users
      // requestUser에서 response.result가 failure일 때
      case .failure(let error):   print(error)
      }
    }
    

    
//    // Interval : 526451656 secconds
//    Date(timeIntervalSinceReferenceDate: 526451656) // 2000.01.01 기준.
//    Date(timeIntervalSince1970: 526451656)          // 1970.01.01 기준. (Unix/Posix time)
    
//    if let data = jsonData {
//      do {
//        let decodedData = try JSONDecoder().decode(User.self, from: data)
//        print(decodedData)
//      } catch {
//        print(error)
//      }
//    } else {
//      print("Invalid JSON Data")
//    }
  }
  
  func requestCellData(_ cell: UITableViewCell, for indexPath: IndexPath) {
    let user = users[indexPath.row]
    serviceManager.requestImage(user.photo) { (response) in
//      switch response {
//      case .success(let data):
//      case .failure(let error):
//      }
      guard let data = try? response.get() else { return }
      
      // 받아오기 전에 셀을 스크롤링해서 없어질 수도 있으니까
      // 그 데이터는 사용하지 않아야하므로(재사용에 의해 이상한 cell에 들어갈 수도 있으니까)
      // cell이 내가 요청한 cell과 같은지 비교해서, 아직 화면에 남아있을 때만 넣는 것
      if let cell = self.tableView.cellForRow(at: indexPath) {
        cell.textLabel?.text = user.fullName
        cell.detailTextLabel?.text = user.email
        cell.imageView?.image = UIImage(data: data)
      }
    }
  }


}

// MARK:- UITableViewDataSource

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.users.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    requestCellData(cell, for: indexPath)
    return cell
  }
}

