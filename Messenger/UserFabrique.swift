//
//  UserFabrique.swift
//  Messenger
//
//  Created by Krasa on 24.12.17.
//  Copyright © 2017 Krasa. All rights reserved.
//

import CoreData

class UserFabrique
{
    class func setUser ( id : Int64 , name : String , age : Int64 , context : NSManagedObjectContext )
    {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        let predicate = NSPredicate(format: "id=%lld", id)
        fetchRequest.predicate = predicate
        
        let fetchResults = try? context.fetch(fetchRequest) as! [User]
        
        if fetchResults!.count == 0
        {
            let user = NSEntityDescription.insertNewObject(forEntityName: "User", into: context) as! User
            
            user.id = id
            user.name = name
            user.age = age
        }
        else
        {
            let user = fetchResults![0]
            
            user.name = name
            user.age = age
        }
    }
    
    class func getUser ( id : Int64 , context : NSManagedObjectContext ) -> User?
    {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        let predicate = NSPredicate(format: "id=%lld", id)
        fetchRequest.predicate = predicate
        
        let fetchResults = try? context.fetch(fetchRequest) as! [User]

        return fetchResults!.count == 0 ? nil : fetchResults![0]
    }
}
