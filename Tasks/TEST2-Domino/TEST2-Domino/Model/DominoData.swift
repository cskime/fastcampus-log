//
//  DominoData.swift
//  DominoStarter
//
//  Created by Lee on 2019/12/27.
//  Copyright © 2019 Kira. All rights reserved.
//

import Foundation

// MARK:- Product Model

struct Menu {
    let category: String
    let products: [Product]
}

struct Product: Equatable {
    let name: String
    let price: Int
    let thumbnail: String
}

// MARK:- User Data Model

typealias WishListData = (products: [Product], ordered: [Int])

class WishList {
    
    static let shared = WishList()
    
    private init() { }
    
    private var products = [Product]()
    private var ordered = [Int]()
    
    // MARK: Fetch Data
    
    func fetch() -> WishListData {
        return (self.products, self.ordered)
    }
    
    func orderedCount(of newValue: Product) -> Int {
        if let index = products.firstIndex(where: { (product) -> Bool in product == newValue }) {
            return ordered[index]
        } else {
            return 0
        }
    }
    
    // MARK: Update Data
    
    func removeAll() {
        products.removeAll()
        ordered.removeAll()
    }
    
    enum Command {
        case add, subtract
    }
    func perform(command: WishList.Command, product newValue: Product) -> Int {
        switch command {
        case .add:
            return self.add(product: newValue)
        case .subtract:
            return self.subtract(product: newValue)
        }
    }
    
    private func add(product newValue: Product) -> Int {
        if let index = products.firstIndex(where: { (product) -> Bool in product == newValue }) {
            ordered[index] += 1
            return ordered[index]
        } else {
            products.append(newValue)
            ordered.append(1)
            return 1
        }
    }
    
    private func subtract(product newValue: Product) -> Int {
        if let index = products.firstIndex(where: { (product) -> Bool in product == newValue }) {
            ordered[index] -= 1
            if ordered[index] == 0 {
                products.remove(at: index)
                ordered.remove(at: index)
                return 0
            }
            return ordered[index]
        } else {
            return 0
        }
    }
}

// MARK:- Common Data Source

struct MenuData {
    private let data: [Menu] = [
        Menu(
            category: String(describing: 카테고리.슈퍼시드.self),
            products: [
                Product(name: 카테고리.슈퍼시드.글램핑바비큐, price: 10000, thumbnail: 카테고리.슈퍼시드.글램핑바비큐),
                Product(name: 카테고리.슈퍼시드.알로하하와이안, price: 10000, thumbnail: 카테고리.슈퍼시드.알로하하와이안),
                Product(name: 카테고리.슈퍼시드.우리고구마, price: 10000, thumbnail: 카테고리.슈퍼시드.우리고구마),
                Product(name: 카테고리.슈퍼시드.콰트로치즈퐁듀, price: 10000, thumbnail: 카테고리.슈퍼시드.콰트로치즈퐁듀),
            ]
        ),
        Menu(
            category: String(describing: 카테고리.프리미엄.self),
            products: [
                Product(name: 카테고리.프리미엄.더블크러스트, price: 10000, thumbnail: 카테고리.프리미엄.더블크러스트),
                Product(name: 카테고리.프리미엄.블랙앵거스, price: 10000, thumbnail: 카테고리.프리미엄.블랙앵거스),
                Product(name: 카테고리.프리미엄.블랙타이거, price: 10000, thumbnail: 카테고리.프리미엄.블랙타이거),
                Product(name: 카테고리.프리미엄.와규앤비스테카, price: 10000, thumbnail: 카테고리.프리미엄.와규앤비스테카),
                Product(name: 카테고리.프리미엄.직화스테이크, price: 10000, thumbnail: 카테고리.프리미엄.직화스테이크),
            ]
        ),
        Menu(
            category: String(describing: 카테고리.클래식.self),
            products: [
                Product(name: 카테고리.클래식.베이컨체더치즈, price: 10000, thumbnail: 카테고리.클래식.베이컨체더치즈),
                Product(name: 카테고리.클래식.불고기, price: 10000, thumbnail: 카테고리.클래식.불고기),
                Product(name: 카테고리.클래식.슈퍼디럭스, price: 10000, thumbnail: 카테고리.클래식.슈퍼디럭스),
                Product(name: 카테고리.클래식.슈퍼슈프림, price: 10000, thumbnail: 카테고리.클래식.슈퍼슈프림),
                Product(name: 카테고리.클래식.페퍼로니, price: 10000, thumbnail: 카테고리.클래식.페퍼로니),
                Product(name: 카테고리.클래식.포테이토, price: 10000, thumbnail: 카테고리.클래식.포테이토),
            ]
        ),
        Menu(
            category: String(describing: 카테고리.사이드디시.self),
            products: [
                Product(name: 카테고리.사이드디시.딸기슈크림, price: 7000, thumbnail: 카테고리.사이드디시.딸기슈크림),
                Product(name: 카테고리.사이드디시.슈퍼곡물치킨, price: 7000, thumbnail: 카테고리.사이드디시.슈퍼곡물치킨),
                Product(name: 카테고리.사이드디시.애플크러스트디저트, price: 7000, thumbnail: 카테고리.사이드디시.애플크러스트디저트),
                Product(name: 카테고리.사이드디시.치킨퐁듀그라탕, price: 7000, thumbnail: 카테고리.사이드디시.치킨퐁듀그라탕),
                Product(name: 카테고리.사이드디시.퀴노아치킨샐러드, price: 7000, thumbnail: 카테고리.사이드디시.퀴노아치킨샐러드),
                Product(name: 카테고리.사이드디시.포테이토순살치킨, price: 7000, thumbnail: 카테고리.사이드디시.포테이토순살치킨),
            ]
        ),
        Menu(
            category: String(describing: 카테고리.음료.self),
            products: [
                Product(name: 카테고리.음료.미닛메이드, price: 3000, thumbnail: 카테고리.음료.미닛메이드),
                Product(name: 카테고리.음료.스프라이트, price: 3000, thumbnail: 카테고리.음료.스프라이트),
                Product(name: 카테고리.음료.코카콜라, price: 3000, thumbnail: 카테고리.음료.코카콜라),
                Product(name: 카테고리.음료.코카콜라제로, price: 3000, thumbnail: 카테고리.음료.코카콜라제로),
            ]
        ),
        Menu(
            category: String(describing: 카테고리.피클소스.self),
            products: [
                Product(name: 카테고리.피클소스.갈릭디핑, price: 500, thumbnail: 카테고리.피클소스.갈릭디핑),
                Product(name: 카테고리.피클소스.스위트칠리소스, price: 500, thumbnail: 카테고리.피클소스.스위트칠리소스),
                Product(name: 카테고리.피클소스.우리피클L, price: 500, thumbnail: 카테고리.피클소스.우리피클L),
                Product(name: 카테고리.피클소스.우리피클M, price: 500, thumbnail: 카테고리.피클소스.우리피클M),
                Product(name: 카테고리.피클소스.핫소스, price: 500, thumbnail: 카테고리.피클소스.핫소스),
            ]
        )
    ]
    
    // MARK:- Interface

    func numberOfCategory() -> Int {
        return data.count
    }

    func category(at index: Int) -> String {
        return data[index].category
    }

    func numberOfProducts(at index: Int) -> Int {
        return products(at: index).count
    }

    func products(at index: Int) -> [Product] {
        return data[index].products
    }

}

