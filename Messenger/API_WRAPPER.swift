//
//  API_WRAPPER.swift
//  Messenger
//
//  Created by Krasa on 04.01.18.
//  Copyright © 2018 Krasa. All rights reserved.
//

import Foundation
import SwiftyJSON

class API_WRAPPER
{
    class func getData ( success : @escaping (JSON)-> Void , failure : @escaping (Int) -> Void )
    {
        let urlString = "https://www.flickr.com/services/rest?method=flickr.interestingness.getList&api_key=3988023e15f45c8d4ef5590261b1dc53&per_page=20&page=1&format=json&nojsoncallback=1"
        
        let url = URL(string: urlString)
        
        URLSession.shared.dataTask(with: url!, completionHandler: { (data,response,error) in
        
            if error != nil
            {
                print((error as! NSError).code)
                failure( (error as! NSError).code )
            }
            else
            {
                let json = JSON(data!)
                success(json)
            }
        }).resume()
        
    }
}
