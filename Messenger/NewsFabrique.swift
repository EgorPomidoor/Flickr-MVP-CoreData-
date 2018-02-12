//
//  NewsFabrique.swift
//  Messenger
//
//  Created by Krasa on 04.01.18.
//  Copyright © 2018 Krasa. All rights reserved.
//

import CoreData

class NewsFabrique
{
    class func setNews ( id : String , url : String , title : String , context : NSManagedObjectContext )
    {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "News")
        let predicate = NSPredicate(format: "id=%@", id)
        fetchRequest.predicate = predicate
        
        let fetchResults = try? context.fetch(fetchRequest) as! [News]
        
        if fetchResults!.count == 0
        {
            let news = NSEntityDescription.insertNewObject(forEntityName: "News", into: context) as! News
            
            news.id = id
            news.url = url
            news.title = title
        }
        else
        {
            let news = fetchResults![0]
            
            news.url = url
            news.title = title
        }
    }
}
