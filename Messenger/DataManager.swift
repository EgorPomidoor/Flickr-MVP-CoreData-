//
//  DataManager.swift
//  Messenger
//
//  Created by Krasa on 04.01.18.
//  Copyright © 2018 Krasa. All rights reserved.
//

import Foundation

class DataManager
{
    class func getData ( success : @escaping () -> Void , failure : @escaping (Int) -> Void )
    {
        API_WRAPPER.getData(success: { (response) in
        
            print(response)
            let photosObject = response["photos"]
            let photosArray = photosObject["photo"].arrayValue
            let backgroundContext = CoreDataManager.sharedInstance.getBackgroudContext()
            
            for i in 0..<photosArray.count
            {
                let photo = photosArray[i]
                
                let id = photo["id"].stringValue
                let farmId = photo["farm"].int64Value
                let serverId = photo["server"].int64Value
                let secret = photo["secret"].stringValue
                let title = photo["title"].stringValue

                let photoURL = "https://farm\(farmId).staticflickr.com/\(serverId)/\(id)_\(secret).jpg"
                
                let postObject = Post()
                
                postObject.id = id
                postObject.title = title
                postObject.url = photoURL
                
                NewsFabrique.setNews(id: id, url: photoURL, title: title, context: backgroundContext)
            }
            
            _ = try? backgroundContext.save()
            success()
            
        }, failure: failure)
    }
}
