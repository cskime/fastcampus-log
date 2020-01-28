//
//  Section.swift
//  CollectionViewExercises
//
//  Created by Giftbot on 2020/01/28.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import UIKit

struct Section {
  var cards: [Card]
}

var sections: [Section] = [
  Section(cards: cards.shuffled()),
  Section(cards: cards.shuffled()),
  Section(cards: cards.shuffled()),
  Section(cards: cards.shuffled()),
  Section(cards: cards.shuffled()),
]
