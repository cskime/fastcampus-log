//
//  Common.swift
//  DominoStarter
//
//  Created by cskim on 2019/12/27.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

// MARK:- Root View Controller Generator

final class RootViewControllerGenerator {
    static func make() -> UIViewController {
        let listVC = ListViewController()
        let wishVC = WishListViewController()
        
        let listNaviVC = UINavigationController(rootViewController: listVC)
        listNaviVC.tabBarItem = UITabBarItem(title: "Domino's", image: UIImage(named: TabBarImage.domino), tag: 0)
        let wishNaviVC = UINavigationController(rootViewController: wishVC)
        wishNaviVC.tabBarItem = UITabBarItem(title: "WishList", image: UIImage(named: TabBarImage.wishlist), tag: 1)
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [listNaviVC, wishNaviVC]
        
        return tabBarController
    }
}

// MARK:- Assets Image Modeling

struct 카테고리 {
    struct 사이드디시 {
        static let 딸기슈크림 = "딸기 슈크림"
        static let 슈퍼곡물치킨 = "슈퍼곡물 치킨"
        static let 애플크러스트디저트 = "애플 크러스트 디저트"
        static let 치킨퐁듀그라탕 = "치킨퐁듀 그라탕"
        static let 퀴노아치킨샐러드 = "퀴노아 치킨 샐러드"
        static let 포테이토순살치킨 = "포테이토 순살치킨"
    }
    
    struct 슈퍼시드 {
        static let 글램핑바비큐 = "글램핑 바비큐"
        static let 알로하하와이안 = "알로하 하와이안"
        static let 우리고구마 = "우리 고구마"
        static let 콰트로치즈퐁듀 = "콰트로 치즈 퐁듀"
    }
    
    struct 음료 {
        static let 미닛메이드 = "미닛메이드 스파클링 청포도"
        static let 스프라이트 = "스프라이트"
        static let 코카콜라제로 = "코카콜라 제로"
        static let 코카콜라 = "코카콜라"
    }
    
    struct 클래식 {
        static let 베이컨체더치즈 = "베이컨체더치즈"
        static let 불고기 = "불고기"
        static let 슈퍼디럭스 = "슈퍼디럭스"
        static let 슈퍼슈프림 = "슈퍼슈프림"
        static let 페퍼로니 = "페퍼로니"
        static let 포테이토 = "포테이토"
    }
    
    struct 프리미엄 {
        static let 더블크러스트 = "더블크러스트 이베리코"
        static let 블랙앵거스 = "블랙앵거스 스테이크"
        static let 블랙타이거 = "블랙타이거 슈림프"
        static let 와규앤비스테카 = "와규 앤 비스테카"
        static let 직화스테이크 = "직화 스테이크"
    }
    
    struct 피클소스 {
        static let 갈릭디핑 = "갈릭 디핑 소스"
        static let 스위트칠리소스 = "스위트 칠리소스"
        static let 우리피클L = "우리 피클 L"
        static let 우리피클M = "우리 피클 M"
        static let 핫소스 = "핫소스"
    }
}

struct TabBarImage {
    static let domino = "domino's"
    static let wishlist = "wishlist"
}

// MARK:- Common Used Color

struct Color {
    static let orderControl: UIColor = #colorLiteral(red: 0.2588235294, green: 0.2745098039, blue: 0.2980392157, alpha: 1)
}
