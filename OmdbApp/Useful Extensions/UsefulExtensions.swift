//
//  UsefulExtensions.swift
//  OmdbApp
//
//  Created by cedcoss on 25/05/21.
//

import Foundation
import UIKit

extension NSObject {
    static var className: String {
        return String(describing: self)
    }
}

extension UIView {
    func addLoader(){
        let activity: UIActivityIndicatorView
        if #available(iOS 13.0, *) {
            activity = UIActivityIndicatorView(style: .large)
        } else {
            // Fallback on earlier versions
            activity = UIActivityIndicatorView(style: .whiteLarge)
        }
        activity.frame.size = CGSize(width: 100, height: 100)
        activity.color = dynamicColor.label
        activity.center = self.center
        activity.tag = 12334
        activity.hidesWhenStopped = true
        activity.startAnimating()
        self.addSubview(activity)
    }
    
    func stopLoader(){
        if let activity = self.viewWithTag(12334) as? UIActivityIndicatorView {
            activity.stopAnimating()
            activity.removeFromSuperview()
        }
    }
    func addStyle(){
        self.layer.cornerRadius     = 10.0
        self.layer.shadowColor      = dynamicColor.label.cgColor
        self.layer.shadowOffset     = .zero
        self.layer.shadowOpacity    = 0.2
        self.backgroundColor        = dynamicColor.systemBackground
        self.layer.shadowRadius     = 2.0
    }
    
    
    func addShadow(withOpacity opacity: Float) {
        self.layer.shadowColor = dynamicColor.label.cgColor
        self.layer.shadowRadius = 5.0
        self.layer.shadowOffset = .zero
        self.layer.shadowOpacity = opacity
    }
}


enum Color: String {
    case red
    case green
    case blue
    case yellow
    
    var create: UIColor{
        switch self {
        case .red:
            return UIColor.systemRed
        case .blue:
            return UIColor.systemBlue
        case .green:
            return UIColor.systemGreen
        case .yellow:
            return UIColor.systemYellow
        }
    }
}
