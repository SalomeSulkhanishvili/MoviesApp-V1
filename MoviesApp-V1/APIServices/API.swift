//
//  API.swift
//  MoviesApp-V1
//
//  Created by ekaterine iremashvili on 10/9/20.
//

import UIKit

class APIServices {
    
    static func get<T: Codable>(url: String, completion: @escaping (T)->Void) {
        guard let url = URL(string: url) else {return}
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            
            guard let data = data else {return}
            
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(T.self, from: data)
                
                completion(decodedData)
            } catch let err {
                print("failed to decode json \(err)")
            }
            
        }.resume()
    }
}
