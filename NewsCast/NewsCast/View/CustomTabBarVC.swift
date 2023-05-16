//
//  TabBarVC.swift
//  NewsCast
//
//  Created by Ahmet Akgün on 11.05.2023.
//

import Foundation
import UIKit
class CustomTabBarvc: UITabBarController, UITabBarControllerDelegate {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.selectedIndex = 1
        setupMiddleButton()
    }
    func setupMiddleButton() {
        let middleButton = UIButton()
        middleButton.translatesAutoresizingMaskIntoConstraints = false
        
        middleButton.setBackgroundImage(UIImage(named: "home"), for: .normal)
        middleButton.layer.shadowColor = UIColor.black.cgColor
        middleButton.layer.shadowOpacity = 0.1
        middleButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        
        self.tabBar.addSubview(middleButton)
        middleButton.addTarget(self, action: #selector(menuButtonAction), for: .touchUpInside)

        // Constraints
        middleButton.centerXAnchor.constraint(equalTo: self.tabBar.centerXAnchor).isActive = true
        middleButton.widthAnchor.constraint(equalToConstant: 55).isActive = true
        middleButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        if #available(iOS 11.0, *) {
            middleButton.bottomAnchor.constraint(equalTo: self.tabBar.safeAreaLayoutGuide.bottomAnchor, constant: -7).isActive = true
        } else {
            middleButton.bottomAnchor.constraint(equalTo: self.tabBar.bottomAnchor, constant: -7).isActive = true
        }
    }

    @objc func menuButtonAction(sender: UIButton) {
        self.selectedIndex = 1
    }
  
}
    extension UIView {

        @IBInspectable var cornerRadius: CGFloat{
            get{return self.cornerRadius}
            set{
                self.layer.cornerRadius = newValue
            }
        }
    }
