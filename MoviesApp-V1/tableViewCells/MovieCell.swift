//
//  MovieCell.swift
//  MoviesApp-V1
//
//  Created by ekaterine iremashvili on 10/8/20.
//

import UIKit

enum GeneralCategory: String{
    case Popular = "popular"
    case Trending = "trending"
}

enum SubCategory: String {
    case TV = "tv"
    case Movie = "movie"
    case Today = "day"
    case ThisWeek = "week"
}

class MovieCell: UITableViewCell {
    static var identifier = "MovieCell"

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryController: UISegmentedControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var movieModel = [Result]()
    var generalC : GeneralCategory?
    var subC: SubCategory?
    var selectedModel: Result?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    @IBAction func changeCategory(_ sender: UISegmentedControl) {
        //print("\(sender.selectedSegmentIndex)")
        changeSubCategory(category: generalC!, subC: subC!)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initCollection(){
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.categoryController.clipsToBounds = true
        let movieCell = UINib(nibName: DetailMovieCell.identifier, bundle: nil)
        self.collectionView.register(movieCell, forCellWithReuseIdentifier: DetailMovieCell.identifier)
    }
    
    func setData(data: [Result]){
        self.movieModel = data
        self.initCollection()
        self.collectionView.reloadData()
    }
    
    func changeSubCategory(category: GeneralCategory, subC: SubCategory){
        NotificationCenter.default.post(
            name: .changeSubCategoryChannelID,
            object: nil,
            userInfo: ["category" : category,
                       "sub category": subC])
    }

    
    func moveToSelectedMovie(){
        NotificationCenter.default.post(
            name: .moveToMovieDetailChannelID,
            object: nil,
            userInfo: ["model": selectedModel!,
                       "category": generalC!,
                       "sub category": subC!])
    }
    
    deinit {
        print("remove notification")
        NotificationCenter.default.removeObserver(self)
    }
    
}

//MARK: collectionView
extension MovieCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{

    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailMovieCell.identifier, for: indexPath) as! DetailMovieCell
        let movie = movieModel[indexPath.row]
        cell.movieModel = movie
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        selectedModel = movieModel[indexPath.row]
        moveToSelectedMovie()
        //notification to move info + perform segue in mainViewController
        
    }
    
    
    
    
    
    
}
