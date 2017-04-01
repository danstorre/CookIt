//
//  DBImage.swift
//  CookIt
//
//  Created by Daniel Torres on 4/1/17.
//  Copyright © 2017 Danieltorres. All rights reserved.
//

import Foundation
import UIKit
import CoreData


extension DBImage {
    
    struct propertyNames {
        static let creationDate = "creationDate"
        static let imageData = "imageData"
        static let id = "id"
    }
    
    convenience init(data: NSData? = nil, id: String? = nil, context: NSManagedObjectContext) {
        
        if let ent = NSEntityDescription.entity(forEntityName: "DBImage", in: context) {
            self.init(entity: ent, insertInto: context)
            self.creationDate = NSDate()
            self.imageData = data
            self.id = id
            
        } else {
            fatalError("Unable to find Entity name!")
        }
        
    }

    class func get(id: String, context: NSManagedObjectContext) -> DBRecipe? {
        let predicate = NSPredicate(format: "\(propertyNames.id) == \(id)")
        return self.list(predicate: predicate, context: context).fetchedObjects?.first
    }
    
    class func list(predicate: NSPredicate? = nil, fetchLimit: Int = 0, context: NSManagedObjectContext) -> NSFetchedResultsController<DBRecipe> {
        
        
        let fetchRequest = NSFetchRequest<DBRecipe>(entityName: self.entityName())
        fetchRequest.fetchLimit = 0
        fetchRequest.fetchBatchSize = 20
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: propertyNames.id, ascending: true)]
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        do {
            try fetchedResultsController.performFetch()
        }catch {
            
        }
        return fetchedResultsController
    }
    
    class func insertOrUpdate(in recipe: DBRecipe, this image: UIImage, context: NSManagedObjectContext) -> Bool{
        
        recipe.image = DBImage(data: UIImageJPEGRepresentation(image, 1) as NSData?, id: String(recipe.id), context: context)
        
        return true
    }
    
    
    
}
