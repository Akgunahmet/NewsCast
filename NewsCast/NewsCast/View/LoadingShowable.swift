//
//  LoadingShowable.swift
//  NewsCast
//
//  Created by Ahmet Akgün on 18.05.2023.
//

import UIKit
// MARK: Protocol
protocol LoadingShowable where Self: UIViewController {
    func showLoading()
    func hideLoading()
}
// MARK: Extension
extension LoadingShowable {
    func showLoading() {
        LoadingView.shared.startLoading()
    }
    
    func hideLoading() {
        LoadingView.shared.hideLoading()
    }
}
