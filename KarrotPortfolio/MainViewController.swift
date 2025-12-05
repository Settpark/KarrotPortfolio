//
//  ViewController.swift
//  KarrotPortfolio
//
//  Created by temp_name on 12/4/25.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTabs()
    }
    
    private func setupTabs() {
        let homeVC = UINavigationController(rootViewController: HomeViewController())
        homeVC.tabBarItem = UITabBarItem(
            title: "홈",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )
        
        self.viewControllers = [homeVC]
    }
}
