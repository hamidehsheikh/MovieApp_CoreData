//
//  AddMovieViewModel.swift
//  MovieApp
//
//  Created by Hamideh Sheikh on 3/9/23.
//

import Foundation

class AddMovieViewModel: ObservableObject {
    
    var title: String = ""
    var director: String = ""
    var releaseDate: Date = Date()
    @Published var rating: Int? = nil
    
    func save() {
        let manager = CoreDataManager.shared
        let movie = Movie(context: manager.persistentContainer.viewContext)
        
        movie.title = title
        movie.director = director
        movie.rating = Double(rating ?? 0)
        movie.releaseDate = releaseDate
        
        manager.save()
    }
    
}
