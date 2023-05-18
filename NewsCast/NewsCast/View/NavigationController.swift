//
//  NavigationController.swift
//  NewsCast
//
//  Created by Ahmet Akgün on 15.05.2023.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.tintColor = UIColor.darkGray
        navigationController?.navigationBar.barTintColor = .blue // veya istediğiniz renk

        // Navigation barın altındaki çizginin rengini belirleyin
        navigationController?.navigationBar.shadowImage = UIImage() // Çizgiyi gizlemek için boş bir görüntü atıyoruz
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default) // Arka plan görüntüsünü sıfırlıyoruz
    }
}

