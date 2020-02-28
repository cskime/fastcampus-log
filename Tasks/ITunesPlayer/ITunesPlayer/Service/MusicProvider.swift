//
//  MusicProvider.swift
//  ITunesPlayer
//
//  Created by cskim on 2020/02/28.
//  Copyright © 2020 cskim. All rights reserved.
//

import Alamofire

class MusicProvider {
  
  private var musicRequest: DataRequest? = nil {
    didSet { oldValue?.cancel() } // 검색 중 다른 것을 검색하면 기존 request를 취소하고 다음 검색 시작
  }
  
  func request(with term: String, completion: @escaping (Result<Musics, Error>)->Void) {
    let url = SearchURL()
      .addQuery(key: .term, value: term)
      .addQuery(key: .country, value: "US")
      .addQuery(key: .media, value: "music")
      .addQuery(key: .entity, value: "song")
      .resolvedURL()
    
    self.musicRequest = AF.request(url)
    self.musicRequest?
      .validate()
      .responseDecodable { (response: DataResponse<Musics, AFError>) in
        switch response.result {
        case .success(let musics):  completion(.success(musics))
        case .failure(let error):   completion(.failure(error))
        }
    }
  }
  
  func requestArtwork(url: String, completion: @escaping (Result<Data, Error>)->Void) -> URLSessionTask? {
    let request = AF.request(url)
      
    request
      .validate(contentType: ["image/jpeg"])    // jpeg image만 validation 통과
      .responseData { (response) in
        guard let data = response.data else { return }
        completion(.success(data))
    }
    
    return request.task
  }
  
//  func requestArtwork(url: String, completion: @escaping (Result<Data, Error>)->Void) {
//    AF.request(url)
//      .validate()
//      .responseData { (response: DataResponse<Data, AFError>) in
//        switch response.result {
//        case .success(let data):  completion(.success(data))
//        case .failure(let error): completion(.failure(error))
//        }
//    }
//  }
}

extension MusicProvider {
  final class SearchURL {
    enum Key: String {
      case term, country, media, entity, lang
    }
    private var baseURL = "https://itunes.apple.com/search?"
    private var query: String = ""
    
    func addQuery(key: Key, value: String) -> Self {
      query += "\(key.rawValue)=\(value)&"
      return self
    }
    
    func resolvedURL() -> String {
      let url = self.baseURL + self.query
      self.query = ""
      return String(url.dropLast())
    }
  }
}

