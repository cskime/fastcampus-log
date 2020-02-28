//
//  Music.swift
//  ITunesPlayer
//
//  Created by cskim on 2020/02/28.
//  Copyright © 2020 cskim. All rights reserved.
//

import Foundation

struct Musics: Decodable {
  let resultCount: Int
  let results: [Music]
  
  struct Music: Decodable {
    let artistName: String
    let trackName: String
    let artworkUrl100: String
    let previewUrl: String
  }
}
