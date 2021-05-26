//
//  AppSetup.swift
//  OmdbApp
//
//  Created by cedcoss on 25/05/21.
//

import Foundation
import UIKit

final class AppSetUp {
    //  MARK: - Major app functionality
    //
    static let baseUrl            = "https://www.omdbapi.com/?apikey=1d094e25"
    static let searchEndpoint     = "&s="
    static let colorarray         = ["red","green","blue","yellow"]
    static let shared             = AppSetUp()
    static let themeColor         = #colorLiteral(red: 0.5960784314, green: 0.368627451, blue: 1, alpha: 1)
    
    //  MARK: - Convert string to UIColor
    
    func getColor(str:String)->UIColor{
        
        let strArr          = str.stripped.lowercased().components(separatedBy: " ")
        var colorIndex      = [Int:String]()
        
        AppSetUp.colorarray.map({color in
            if let index = (strArr.firstIndex(of: color)){
                colorIndex[index] = color
            }
        })
        
        if let minIndex = colorIndex.keys.min(){
            guard let rawValue  = colorIndex[minIndex] else { return dynamicColor.tertiarySystemBackground }
            guard let color     = Color(rawValue: rawValue) else { return dynamicColor.tertiarySystemBackground }
            return color.create
        }
        return dynamicColor.tertiarySystemBackground
    }
}

//  MARK: - Allowed characters

extension String {
    var stripped: String {
        let okayChars = Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890+-=.!_")
        return self.filter {okayChars.contains($0) }
    }
}
