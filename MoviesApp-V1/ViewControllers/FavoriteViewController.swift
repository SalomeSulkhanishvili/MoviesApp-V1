//
//  FavoriteViewController.swift
//  MoviesApp-V1
//
//  Created by ekaterine iremashvili on 10/13/20.
//

import UIKit

class FavoriteViewController: UIViewController {

    @IBOutlet weak var favoriteCollectionView: UICollectionView!
    var selectedModel: Int?
    var movieIDs = [Movie]()
    let API_KEY = "d3fa10fb0c4c3a7403643860403c2935"
    var favoriteList = [Result]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCollectionView()
        fetchFavorites()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    func loadCollectionView(){
        self.favoriteCollectionView.dataSource = self
        self.favoriteCollectionView.delegate = self
        let modelCell = UINib(nibName: FavoriteCell.identifier, bundle: nil)
        self.favoriteCollectionView.register(modelCell, forCellWithReuseIdentifier: FavoriteCell.identifier)
    }
    
    func fetchFavorites(){
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        Coredata.fetchFavoriteMovie(completion: { (responses) in
            self.movieIDs.removeAll()
            for response in responses {
                self.movieIDs.append(response)
                
            }
            
            DispatchQueue.main.async {
                dispatchGroup.leave()
            }
        })
        self.favoriteList.removeAll()
        for model in movieIDs {
            dispatchGroup.enter()
            let cat = String(model.category ?? "")
            let url = "https://api.themoviedb.org/3/\(cat)/\(Int(model.movieID))?api_key=\(API_KEY)&language=en-US"
            APIServices.get(url: url, completion: { (response: Result) in
                self.favoriteList.append(response)
            })
            DispatchQueue.main.async {
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main, execute: {
            print("load data")
            self.favoriteCollectionView.reloadData()
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
//                self.favoriteCollectionView.reloadData()
//            })
        })
    }
    
}

extension FavoriteViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = favoriteCollectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCell.identifier, for: indexPath) as! FavoriteCell
        let movie = favoriteList[indexPath.row]
        cell.modelNameLabel.text = movie.title ?? movie.name ?? movie.originalTitle ?? movie.originalName
        cell.modelDateLabel.text = movie.releaseDate ?? movie.firstAirDate
        movie.posterPath?.downloadImage { (image) in
            DispatchQueue.main.async {
                cell.modelImageView.image = image
            }
        }
        return cell
    }
    
    
}
