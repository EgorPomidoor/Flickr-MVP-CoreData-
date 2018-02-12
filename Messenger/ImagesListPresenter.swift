//
//  ImagesListPresenter.swift
//  Messenger
//
//  Created by Krasa on 04.01.18.
//  Copyright © 2018 Krasa. All rights reserved.
//

import CoreData

class ImagesListPresenter: NSObject
{
    weak var viewInput : ViewInput?
    lazy var fetchedResultController : NSFetchedResultsController<NSFetchRequestResult> = {
    
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "News")
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.sharedInstance.getMainContext(), sectionNameKeyPath: nil, cacheName: nil)
        
        frc.delegate = self
        _ = try? frc.performFetch()
    
    
        return frc
    }()
    
    func getData ()
    {
        DataManager.getData(success: {
            
            CoreDataManager.sharedInstance.save()
            
        }, failure: { errorCode in
        
        
        })
    }
}

//MARK:- протокол PresenterInput
extension ImagesListPresenter : PresenterInput
{
    func viewLoaded(view: ViewInput)
    {
        viewInput = view
        getData()
    }
}

//MARK:- протокол PresenterOutput
extension ImagesListPresenter : PresenterOutput
{
    func numberOfEntities() -> Int
    {
        if let objectsArray = fetchedResultController.fetchedObjects
        {
            return objectsArray.count
        }
        
        return 0
    }
    
    func entityAt ( indexPath : IndexPath ) -> Any?
    {
        return fetchedResultController.object(at: indexPath)
    }
}

//MARK:- протокол FetchedResultsControllerDelegate
extension ImagesListPresenter : NSFetchedResultsControllerDelegate
{
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>)
    {
        viewInput?.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?)
    {
        if type == .insert
        {
            viewInput?.insert(at: newIndexPath!)
        }
        
        if type == .update
        {
            viewInput?.update(at: indexPath!)
        }
        
        if type == .move
        {
            viewInput?.move(from: indexPath!, to: newIndexPath!)
        }
        
        if type == .delete
        {
            viewInput?.delete(at: indexPath!)
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>)
    {
        viewInput?.endUpdates()
    }
}
