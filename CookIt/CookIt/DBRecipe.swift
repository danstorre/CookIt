//
//  DBRecipe.swift
//  CookIt
//
//  Created by Daniel Torres on 3/29/17.
//  Copyright © 2017 Danieltorres. All rights reserved.
//

import Foundation

import CoreData

extension NSManagedObject {
    
    public class func entityName() -> String {
        let name = NSStringFromClass(self)
        return name.components(separatedBy: ".").last!
    }
    
}

extension DBRecipe {
    
    struct propertyNames {
        static let id = "id"
        static let title = "title"
        static let readyInMinutes = "readyInMinutes"
        static let imageString = "imageString"
        static let baseUri = "baseUri"
        static let vegetarian = "vegetarian"
        static let glutenFree = "glutenFree"
        static let cheap = "cheap"
        static let sustainable = "sustainable"
        static let servings = "servings"
        static let instructions = "instructions"
        static let calories = "calories"
        static let protein = "protein"
        static let fat = "fat"
        static let carbs = "carbs"
    }
    
    class func get(id: Int64, context: NSManagedObjectContext) -> DBRecipe? {
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
    
    class func insertOrUpdate(with recipe: Recipe, context: NSManagedObjectContext) -> Bool{
        
        var dbRecipe: DBRecipe
        
        if let result = DBRecipe.get(id: Int64(recipe.id!), context: context) {
            dbRecipe = result
        }else {
            dbRecipe = NSEntityDescription.insertNewObject(forEntityName: self.entityName(), into: context) as! DBRecipe
        }
        
        transformToDBRecipe(from: recipe, to: &dbRecipe)
        
        
        return true
        
    }
    
    /*
     @NSManaged public var baseUri: String?
     @NSManaged public var calories: String?
     @NSManaged public var carbs: String?
     @NSManaged public var cheap: Bool
     @NSManaged public var fat: String?
     @NSManaged public var glutenFree: Bool
     @NSManaged public var id: Int64
     @NSManaged public var imageString: String?
     @NSManaged public var instructions: String?
     @NSManaged public var protein: String?
     @NSManaged public var servings: Int16
     @NSManaged public var sustainable: Bool
     @NSManaged public var title: String?
     @NSManaged public var vegetarian: Bool
     @NSManaged public var image: DBImage?
     @NSManaged public var ingredients: NSSet?
     */
    
    class func transformToDBRecipe(from recipe: Recipe, to dbRecipe: inout DBRecipe)  {

        
        
        if let id = recipe.id {
            dbRecipe.id = Int64(id)
        }
        
        if let title = recipe.title {
            dbRecipe.title = title
        }

        if let readyInMinutes = recipe.readyInMinutes {
            dbRecipe.readyInMinutes = Int16(readyInMinutes)
        }
        
        if let baseUri = recipe.baseUri {
            dbRecipe.baseUri = baseUri
        }
        
        if let vegetarian = recipe.vegetarian {
            dbRecipe.vegetarian = vegetarian
        }
        
        if let glutenFree = recipe.glutenFree {
            dbRecipe.glutenFree = glutenFree
        }
        
        if let cheap = recipe.cheap {
            dbRecipe.cheap = cheap
        }
        
        if let sustainable = recipe.sustainable {
            dbRecipe.sustainable = sustainable
        }
        
        if let servings = recipe.servings {
            dbRecipe.servings = Int16(servings)
        }
        
        if let calories = recipe.calories {
            dbRecipe.calories = Int16(calories)
        }
        
        if let protein = recipe.protein {
            dbRecipe.protein = protein
        }
        
        if let fat = recipe.fat{
            dbRecipe.fat = fat
        }
        
        if let carbs = recipe.carbs {
            dbRecipe.carbs = carbs
        }
        
        if let instructions = recipe.instructions{
            dbRecipe.instructions = instructions
        }
        
        if let imageString = recipe.imageString {
            dbRecipe.imageString = imageString
        }
        
        if let imageData = recipe.image {
            _ = DBImage.insertOrUpdate(in: dbRecipe, this: imageData, context: dbRecipe.managedObjectContext!)
        }
        
        
        
    }
    
    
    
    
}
