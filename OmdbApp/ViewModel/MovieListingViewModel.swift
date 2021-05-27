//
//  MovieListingViewModel.swift
//  OmdbApp
//
//  Created by cedcoss on 25/05/21.
//

import Foundation
import UIKit
import SwiftyJSON

class MovieListingViewModel {

    //MARK:- Properties
    var controller          : SearchViewController!
    var movieListing        = [SearchDataModel]()

    init(controller: SearchViewController) {
        self.controller     = controller
    }

    func makeNetworkCallForGettingMovies(searchString: String){
        if !searchString.isEmpty{
            Service.shareInstance.getAllMoviesData(searchString: searchString,controller: controller) { (data) in
                do {
                    let json = try JSON(data: data)
                    self.movieListing.removeAll()
                    if json["Response"].stringValue == "True"{
                        //  MARK: - Decoding and model population
                        let decoder               = JSONDecoder()
                        let data                  = try json["Search"].rawData(options: [])
                        self.movieListing        += try decoder.decode([SearchDataModel].self, from: data)
                    }else{
                        self.controller.view.makeToast(json["Error"].stringValue, duration: 1.0,position:.top)
                    }
                    self.controller.tableView.reloadData()
                }
                catch let error{
                    print(error.localizedDescription)
                    Logger.log(.error,"\(error.localizedDescription)==Function: \(#function), line: \(#line), Filepath: \(#filePath)")
                }
            }
        }else{
            self.movieListing.removeAll()
            self.controller.tableView.reloadData()
        }
    }
}
