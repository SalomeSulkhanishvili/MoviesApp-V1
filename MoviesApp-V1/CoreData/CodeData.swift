//
//  CodeData.swift
//  MoviesApp-V1
//
//  Created by ekaterine iremashvili on 10/13/20.
//

import Foundation
import UIKit
import CoreData


class Coredata {
    //save movie ID
    static func saveMovie(movieID: Int, category: SubCategory){
        let context = AppDelegate.coreDataContainer.viewContext
        
        let movie = Movie(context: context)
        
        movie.movieID = Int64(movieID)
        if category == .Movie{
            movie.category = "movie"
        }else if category == .TV{
            movie.category = "tv"
        }else{
            movie.category = "unknown"
        }

        
        do{
            try context.save()
            print("save movie")
        }catch {print("could not save movie")}
    }
    
    //fetch all favorite movie
    static func fetchFavoriteMovie(completion: @escaping ([Movie])->Void){
        let context = AppDelegate.coreDataContainer.viewContext
        
        let request: NSFetchRequest<Movie> = Movie.fetchRequest()
        
        do{
            let movie = try context.fetch(request)
            completion(movie)
        }catch {
            print("could not fetch movie")
        }
    }
}


