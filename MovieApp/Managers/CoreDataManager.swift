//
//  CoreDataManager.swift
//  MovieApp
//
//  Created by Mohammad Azam on 2/23/21.
//

import Foundation
import CoreData

class CoreDataManager {
    
    var persistentContainer: NSPersistentContainer
    
    static let shared = CoreDataManager()
    
    init() {
        persistentContainer = NSPersistentContainer(name: "MovieAppModel")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Failed to initialized Core Data\(error)")
            }
        }
    }
    
    func getMovieByID(id: NSManagedObjectID) -> Movie? {
        do {
            return try persistentContainer.viewContext.existingObject(with: id) as? Movie
        } catch {
            print("Failed\(error)")
            return nil
        }

    }
    
    func deleteMovie(_ movie: Movie) {
        persistentContainer.viewContext.delete(movie)
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to delete movie\(error)")
        }
    }
    
    func getAllMovies() -> [Movie] {
        let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    func save() {
        do {
            try persistentContainer.viewContext.save()
        } catch {
            print("Failed to save a movie\(error.localizedDescription)")
        }
    }
   
}