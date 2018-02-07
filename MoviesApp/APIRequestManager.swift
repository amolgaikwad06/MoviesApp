//
//  RequestManager.swift
//  MoviesApp
//
//  Created by Amol Gaikwad on 4/9/17.
//  Copyright © 2017 Amol Gaikwad. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

/*
 protocol APIRequestManagerDelegate: class {
 func didReceivedData(sender: APIRequestManager)
 }
 */
class APIRequestManager {
    //weak var delegate: APIRequestManagerDelegate?
    var searchResults = [MovieDetail]()
    var moviesDBObject = MoviesDB()
    var pageNumber = 1
    var pageNumberString: String {
        if pageNumber == 1 {
            return ""
        } else {
            return "&page=\(pageNumber)"
        }
    }
    
    func search(queryString: String) {
        let url = "\(API_URL)\(queryString)\(pageNumberString)"
        Alamofire.request(url).responseJSON { response in
            if let result = response.result.value as? [String: AnyObject] {
                print("Result :\(result)")
                self.moviesDBObject = MoviesDB.populate(with: result as NSDictionary)
                self.searchResults += JSON(self.moviesDBObject.movieDetail).arrayObject as! [MovieDetail]
                
                /*
                 Using Notification
                 */
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: NOTIFICATION_STRING), object: nil)
                
                /*
                 Using Delegation
                 */
                //if self.delegate != nil { self.delegate?.didReceivedData(sender: self) }
            }
        }
    }
    
    func getNextPage(searchText: String) {
        pageNumber += 1
        print("Page Number : \(pageNumber)")
        search(queryString: searchText)
    }
    
    func resetSearch() {
        searchResults = []
    }
}
