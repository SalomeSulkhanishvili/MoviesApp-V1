//
//  StringExtensions.swift
//  MoviesApp-V1
//
//  Created by ekaterine iremashvili on 10/12/20.
//

import UIKit

extension String{
    func downloadImage(completion: @escaping (UIImage?) -> ()) {
        let url_path = "http://image.tmdb.org/t/p/w185\(self)"
        guard let url = URL(string: url_path) else {return}
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            guard let data = data else {return}
            completion(UIImage(data: data))
        }.resume()
    }
}
