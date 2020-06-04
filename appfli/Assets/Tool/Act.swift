//
//  Act.swift
//  appfli
//
//  Created by Hasan Saral on 2.06.2020.
//  Copyright © 2020 com.appfli. All rights reserved.
//

import Foundation

import UIKit
extension UIViewController {
    func showActivityIndicator() {
        let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        activityIndicator.backgroundColor = UIColor(red:0.16, green:0.17, blue:0.21, alpha:1)
        activityIndicator.layer.cornerRadius = 6
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .whiteLarge
        activityIndicator.startAnimating()
        activityIndicator.layer.zPosition = 1
        
        
        activityIndicator.tag = 100
        
        
        for subview in view.subviews {
            if subview.tag == 100 {
                print("already added")
                return
            }
        }
        
        view.addSubview(activityIndicator)
    }
    
    func hideActivityIndicator() {
        let activityIndicator = view.viewWithTag(100) as? UIActivityIndicatorView
        activityIndicator?.stopAnimating()
        
        
        activityIndicator?.removeFromSuperview()
        
        
    }
}
