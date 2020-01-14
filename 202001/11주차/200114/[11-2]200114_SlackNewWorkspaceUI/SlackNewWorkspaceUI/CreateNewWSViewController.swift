//
//  ViewController.swift
//  SlackNewWorkspaceUI
//
//  Created by giftbot on 2020/01/07.
//  Copyright © 2020 giftbot. All rights reserved.
//

import UIKit

final class CreateNewWSViewController: UIViewController {
    
    private let button: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.setTitle("Create New Workspace", for: .normal)
        button.addTarget(self, action: #selector(create(_:)), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupUI()
    }
    
    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        [self.button].forEach { (view) in
            self.view.addSubview(view)
        }
        self.setupConstraints()
    }
    
    private struct UI {
        static let paddingX: CGFloat = 16
    }
    
    private func setupConstraints() {
        let guide = self.view.safeAreaLayoutGuide
        self.button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.button.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: UI.paddingX),
            self.button.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -UI.paddingX),
            self.button.centerYAnchor.constraint(equalTo: guide.centerYAnchor, constant: 0),
        ])
    }
    
    @objc private func create(_ sender: UIButton) {
        let nameWSVC = NameWSViewController()
        let navi = UINavigationController(rootViewController: nameWSVC)
        navi.modalPresentationStyle = .fullScreen
        present(navi, animated: true)
    }
}
