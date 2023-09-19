//
//  DatabaseHelper.swift
//  Jokes
//
//  Created by Emil Zawadzki on 19/09/2023.
//

import UIKit
import CoreData

fileprivate let idField = "jokeID"
fileprivate let ratingField = "rating"
fileprivate let entityName = "JokeEntity"

fileprivate let defaultRating = 1

class DatabaseHelper: NSObject {

	private var container: NSPersistentContainer!
	
	var jokesEntities: [NSManagedObject] = []
	
	override init() {
		super.init()
		loadJokes()
	}
	
	func jokeRating(jokeId: Int) -> Int {
		for jokeEntity in jokesEntities {
			if let entityId = jokeEntity.value(forKey: idField) as? Int, entityId == jokeId {
				return (jokeEntity.value(forKey: ratingField) as? Int) ?? 0
			}
		}
		return defaultRating
	}
	
	func loadJokes() {
		guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
			//TODO
			return
		}
		// get context
		let managedContext = delegate.persistentContainer.viewContext
		// create request
		let fetchRequest =
			NSFetchRequest<NSManagedObject>(entityName: entityName)
		// get jokes data
		do {
			jokesEntities = try managedContext.fetch(fetchRequest)
		} catch let error as NSError {
			//TODO
			print("Could not fetch. \(error), \(error.userInfo)")
		}
		
	}
	
	func saveRating(jokeId: Int, rating: Int) {
		guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
			//TODO
			return
		}
		// get context
		let managedContext = delegate.persistentContainer.viewContext
		// get entity description
		let entity =
			NSEntityDescription.entity(forEntityName: entityName,
									   in: managedContext)!
		var jokeEntity: NSManagedObject?
		for existingEntity in jokesEntities {
			if let entityId = existingEntity.value(forKey: idField) as? Int, entityId == jokeId {
				jokeEntity = existingEntity
			}
		}
		if jokeEntity == nil {
			let newEntity = NSManagedObject(entity: entity,
										  insertInto: managedContext)
			newEntity.setValue(jokeId, forKeyPath: idField)
			jokesEntities.append(newEntity)
			jokeEntity = newEntity
		}
		// set values
		jokeEntity?.setValue(rating, forKeyPath: ratingField)
		// save entity
		do {
			try managedContext.save()
		} catch let error as NSError {
			//TODO
			print("Could not save. \(error), \(error.userInfo)")
		}
	}
	
}
