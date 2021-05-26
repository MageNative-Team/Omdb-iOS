//
//  DynamicColor.swift
//  OmdbApp
//
//  Created by cedcoss on 25/05/21.
//

import Foundation
import UIKit

struct dynamicColor {
    
    //MARK: Background Colors
    static var systemBackground: UIColor = {
       if #available(iOS 13.0, *) { return .systemBackground}
       else { return .white}
     }()
    
    static var secondarySystemBackground: UIColor = {
       if #available(iOS 13.0, *) { return .secondarySystemBackground}
       else { return .darkGray}
     }()

    static var tertiarySystemBackground: UIColor = {
       if #available(iOS 13.0, *) { return .tertiarySystemBackground}
       else { return .lightGray}
     }()
    
    //MARK: - Label Colors
    
    static var label: UIColor = {
       if #available(iOS 13.0, *) { return .label }
       else { return .black }
     }()
    
    static var secondaryLabel: UIColor = {
       if #available(iOS 13.0, *) { return UIColor.secondaryLabel }
       else { return .darkGray }
     }()
    
    static var tertiaryLabel: UIColor = {
       if #available(iOS 13.0, *) { return UIColor.tertiaryLabel }
       else { return .lightGray }
     }()
}
