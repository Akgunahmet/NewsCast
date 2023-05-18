//
//  TabBarVC.swift
//  NewsCast
//
//  Created by Ahmet Akgün on 11.05.2023.
//

import Foundation
import UIKit

class CustomTabBarViewController: UITabBarController, UITabBarControllerDelegate {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        selectedIndex = 1
        setupMiddleButton()
    }
    
    private func setupMiddleButton() {
        let middleButton = UIButton()
        middleButton.translatesAutoresizingMaskIntoConstraints = false
        middleButton.setBackgroundImage(UIImage(named: "home"), for: .normal)
        middleButton.layer.shadowColor = UIColor.black.cgColor
        middleButton.layer.shadowOpacity = 0.1
        middleButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        
        tabBar.addSubview(middleButton)
        middleButton.addTarget(self, action: #selector(menuButtonAction), for: .touchUpInside)
        
        // Constraints
        middleButton.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor).isActive = true
        middleButton.widthAnchor.constraint(equalToConstant: 55).isActive = true
        middleButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        if #available(iOS 11.0, *) {
            middleButton.bottomAnchor.constraint(equalTo: tabBar.safeAreaLayoutGuide.bottomAnchor, constant: -7).isActive = true
        } else {
            middleButton.bottomAnchor.constraint(equalTo: tabBar.bottomAnchor, constant: -7).isActive = true
        }
    }
    
    @objc private func menuButtonAction(sender: UIButton) {
        selectedIndex = 1
        
        if let navigationController = viewControllers?[1] as? UINavigationController,
           let newsCastViewController = navigationController.viewControllers.first as? NewsCastViewController {
            newsCastViewController.fetchNewsCast()
            navigationController.navigationBar.topItem?.title = "NewsCast"
        }
    }
}

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get { return self.layer.cornerRadius }
        set { self.layer.cornerRadius = newValue }
    }
}
