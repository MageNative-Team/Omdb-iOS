//
//  Service.swift
//  OmdbApp
//
//  Created by cedcoss on 25/05/21.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class Service: NSObject{
    
    static let shareInstance = Service()
    
    func getAllMoviesData(searchString: String,controller:UIViewController,completion: @escaping(_ data: Data) -> ()){
        
        let encodedsearchString = searchString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? searchString
        
        let url             = AppSetUp.baseUrl + AppSetUp.searchEndpoint + "\(encodedsearchString)" + "&type=movie"
        guard let urlFinal  = URL(string: url) else {return}
        var request         = URLRequest(url: urlFinal)
        request.httpMethod  = "GET"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.cachePolicy = URLRequest.CachePolicy.returnCacheDataElseLoad
        
        AF.request(request).responseData(completionHandler: {
            response in
            switch response.result{
            case .success:
                do {
                    let json              = try JSON(data: response.data!)
                    guard let data = response.data else {return}
                    completion(data)

                }catch let error {
                    Logger.log(.error,"\(error.localizedDescription)==Function: \(#function), line: \(#line), Filepath: \(#filePath)")
                }
            case .failure(let error):
                Logger.log(.error,"\(error.localizedDescription)==Function: \(#function), line: \(#line), Filepath: \(#filePath)")
                controller.view.makeToast(error.localizedDescription,position:.top)
            }
        })
    }
}
