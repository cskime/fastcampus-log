//
//  ViewController.swift
//  ITunesPlayer
//
//  Created by cskim on 2020/02/28.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit
import AVKit

// AVFoundation : customizing할 때 좋은 더 Low level
// AVKit : 기본기능을 간단하게 사용 가능한 framework

class ViewController: UIViewController {
  
  // MARK: Model
  
  private let provider = MusicProvider()
  private var musics: Musics? {
    didSet {
      self.tableView.reloadData()
    }
  }
  private var artworkRequests = [Int: URLSessionTask]()
  private let player = AVPlayer()
  
  // MARK: Views
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var indicatorView: UIActivityIndicatorView!
  
  private let searchController = UISearchController(searchResultsController: nil)
  private let scopeButtonTitles = ["Search", "Swift", "IU", "Twice", "Adel", "Maroon5"]
  
  // MARK: Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupSearchBar()
    
  }

  // MARK: Search Bar Settings
  
  private func setupSearchBar() {
    navigationItem.searchController = self.searchController
//    self.tableView.tableHeaderView = searchController.searchBar
    
    // Search 부분만 밝고 나머지는 어둡게 처리하는 것. iOS 13부터는 기본 true
    // present되는dim처리를 어디까지 할 것인지 영역을 결정
    // 지정된 vc는 vc의 크기만큼 다음 화면이 나오는 크기가 결정된다
    // 다음 presentation이 될 것의 크기?
    if #available(iOS 13.0, *) { }
    else { self.definesPresentationContext = true }
    // modalPresentation은 화면 전체를 덮음
    // style에서 currentContext를 선택 :
    // style의 overCurrentContext : 기존 내용 유지하면서 ㅇㄹ
    // 해당 style에서 defines~가 true일 때 현재 context를 결정해 주는 것
    // Context로 설정된 vc를 찾아서 current context로 인식하게 만들고 그 크기만큼 다음번에 나오는 vc크기가 결정됨
    // Navigationcontroller는 ture로 설정되어 있기 때문에 navigation conteollr를 덮는 것
    
    // 다음 화면(VC)가 present될 때 
    
    
    searchController.searchBar.tintColor = .red
    // Search 부분만 밝고 나머지는 어둡게 처리하는 것Ididm처리)
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Search Musics"
    //    searchController.searchBar.showsCancelButton = false  // 없을 때는 화면 밑에 터치하면 사라짐
    
    searchController.searchBar.delegate = self
    searchController.searchBar.scopeButtonTitles = self.scopeButtonTitles
  }
  
}

// MARK:- UITableViewDataSource

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.musics?.results.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "MusicCell", for: indexPath)
    
    let music = self.musics?.results[indexPath.row]
    cell.textLabel?.text = music?.trackName
    cell.detailTextLabel?.text = music?.artistName
    
    let task = provider.requestArtwork(url: music?.artworkUrl100 ?? "") { (result) in
      cell.imageView?.image = UIImage(data: try! result.get())
      self.artworkRequests[indexPath.row] = nil
    }
    self.artworkRequests[indexPath.row] = task
    
//    self.configureCell(indexPath: indexPath)
    return cell
  }
  
  private func configureCell(indexPath: IndexPath) {
    guard let music = self.musics?.results[indexPath.row] else { return }
    
    
    
    
//    provider.requestArtwork(url: music.artworkUrl100) { (result) in
//      switch result {
//      case .success(let data):
//        DispatchQueue.global().async {
//          guard let image = UIImage(data: data) else { return }
//          DispatchQueue.main.async {
//            guard let cell = self.tableView.cellForRow(at: indexPath) else { return }
//            cell.configure(track: music.trackName, artist: music.artistName)
//            cell.imageView?.image = image
//          }
//        }
//      case .failure(let error):
//        print(error.localizedDescription)
//      }
//    }
  }
}

// MARK:- UITableViewDelegate

extension ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    self.artworkRequests[indexPath.row]?.cancel()
    self.artworkRequests[indexPath.row] = nil
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let music = musics?.results[indexPath.row], let url = URL(string: music.previewUrl) else { return }
    player.pause()
    let item = AVPlayerItem(url: url)
    self.player.replaceCurrentItem(with: item)
    player.play()
  }
}

// MARK:- UISearchBarDelegate

extension ViewController: UISearchBarDelegate {
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    print("Cancel")
  }
  
  private func requestSongs(term: String) {
    self.indicatorView.startAnimating()
    
    self.provider.request(with: term) { [weak self] (result) in
      switch result {
      case .success(let value):
        self?.musics = value
        self?.tableView.reloadData()
      case .failure(let error):
        print(error.localizedDescription)
      }
      self?.indicatorView.stopAnimating()
    }
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    guard let text = searchBar.text, var term = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
    term = term.trimmingCharacters(in: .whitespacesAndNewlines) // 공백 및 개행 제거
    
    self.provider.request(with: term) { (result) in
      switch result {
      case .success(let musics):  self.musics = musics
      case .failure(let error):   print(error.localizedDescription)
      }
    }
  }
  
  
  // Searchbar 아래 버튼들 중 두 번째 버튼부터 선택한 단어를 Term으로 해서 music 요청
  func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
    print(selectedScope)
    if selectedScope != 0 {
      let term = self.scopeButtonTitles[selectedScope]
      self.requestSongs(term: term)
    }
  }
}
