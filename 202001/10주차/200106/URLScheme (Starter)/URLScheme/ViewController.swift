//
//  ViewController.swift
//  URLScheme
//
//  Created by giftbot on 2020. 1. 4..
//  Copyright © 2020년 giftbot. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBAction private func openSetting(_ sender: Any) {
        print("\n---------- [ openSettingApp ] ----------\n")
        guard let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) else { return }
        
        // 설정 앱 까지만 들어감
        UIApplication.shared.open(url)
        
        // 더 안으로 들어갈 수 있도록
        // 권한을 묻는 것들 등 설정할 것들이 있는 경우 안으로 들어가게 됨
    }
    
    @IBAction private func openMail(_ sender: Any) {
        print("\n---------- [ openMail ] ----------\n")
        
        // 애플 기본 메일 앱이 지워졌거나 설치되지 않았다면 열리지 않음
        // 메일을 연동하지 않았다면 연결창, 연동했었다면 메일 보내기까지 됨
        let scheme = "mailto:"
        let scheme2 = "mailto:someone@mail.com"
        let scheme3 = "mailto:someone1@mail.com,someone2@mail.com,someone3@mail.com"
        let scheme4 = "mailto:someone@mail.com?cc=foo@bar.com&bcc=poo@bar.com&subject=title&body=MyText"
        guard let url = URL(string: scheme), UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction private func openMessage(_ sender: Any) {
        print("\n---------- [ openMessage ] ----------\n")
        
        let scheme = "sms:"
        let scheme2 = "sms:010-1234-5678&body=Hello"
        guard let url = URL(string: scheme), UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction private func openWebsite(_ sender: Any) {
        print("\n---------- [ openWebsite ] ----------\n")
        
        // 기본 브라우저를 사용해서 열기
        let scheme = "https://google.com"
        guard let url = URL(string: scheme), UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction private func openFacebook(_ sender: Any) {
        print("\n---------- [ openFacebook ] ----------\n")
        
        let scheme = "fb:"
//        let scheme = "instagram:"
        guard let url = URL(string: scheme), UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction private func openMyApp(_ sender: Any) {
        print("\n---------- [ openMyApp ] ----------\n")
        
        /*
         쿼리에 데이터를 담아 전달하면 해당 app에서 name, age 값을 받아서 사용
         myApp://host?name=abc&age=10
         - scheme : myApp
         - host: host
         - query: name=abc&age=10
         */
        
        
        let scheme = "myApp1://host?name=abc&age=10"
        guard let url = URL(string: scheme), UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
        
    }
}




