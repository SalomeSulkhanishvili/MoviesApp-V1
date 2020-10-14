//
//  MovieViewController.swift
//  MoviesApp-V1
//
//  Created by ekaterine iremashvili on 10/9/20.
//

import UIKit

class MovieViewController: UIViewController {

    @IBOutlet weak var moviewImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var ganreLabel: UILabel!
    @IBOutlet weak var ratingView: UIView!
    @IBOutlet weak var creatorLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet weak var seriesCastCollectionView: UICollectionView!
    @IBOutlet weak var recommendationsCollectionView: UICollectionView!
    
    var selectedModel: Result?
    let API_KEY = "d3fa10fb0c4c3a7403643860403c2935"
    var cast = [CastElement]()
    var recommentations = [Result]()
    var selectedIndex : Int?
    var selectedCategory: GeneralCategory?
    var selectedSubC: SubCategory?
    var movieIDs = [Int]()
    var favImage = UIImage(named: "InFavorites")
    var notFavImage = UIImage(named: "NotInFavorites")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCollectionViews()
        checkFavorite()
        setUpViews()
        
        loadModel(model: selectedModel!)
        getCast(category: selectedSubC!, movieID: selectedModel!.id ?? 0)
        getRecomendations(category: selectedSubC!, movieID: selectedModel!.id ?? 0)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier, id == PersonDetailViewController.segueIdendifier {
            if let PersonVC = segue.destination as? PersonDetailViewController {
                guard let index = selectedIndex else {return}
                PersonVC.selectedPerson = cast[index]
            }
        }
    }
    
    func setUpViews(){
        onRatingView()
        ratingView.layer.cornerRadius = ratingView.frame.height / 2
        moviewImageView.layer.cornerRadius = 20
        moviewImageView.clipsToBounds = true
    }
    
    //if selectedModel is not in favorites
    //adds selected model id and subCategory in Core Data
    @IBAction func addInFavorites(_ sender: UIButton) {
        guard let id = selectedModel?.id else {return}
        
        if favoriteButton.imageView?.image == favImage {
            print("already saved")
            favoriteButton.setImage(favImage, for: .normal)
        }else{
            print("let's save")
            Coredata.saveMovie(movieID: id, category: selectedSubC ?? .Movie)
            favoriteButton.setImage(favImage, for: .normal)
        }
        
    }
    
    //checks if the Model is in Core Data or not
    func checkFavorite(){
        Coredata.fetchFavoriteMovie(completion: { (responses) in
            self.movieIDs.removeAll()
            for response in responses {
                self.movieIDs.append(Int(response.movieID))
                
            }
            
            DispatchQueue.main.async {
                if self.checkSelectedMovie() {
                    self.favoriteButton.setImage(self.favImage, for: .normal)
                }else{
                    self.favoriteButton.setImage(self.notFavImage, for: .normal)
                }
            }
        })
    }
    
    //if selectedModel id is in movieIDs list
    //output true else false
    func checkSelectedMovie() -> Bool{
        for id in movieIDs {
            if id == selectedModel?.id {
                return true
            }
        }
        return false
    }
    
    //setUp Rating view
    func onRatingView(){
        ratingView.backgroundColor = .clear
        let cp = CircularProgressView(frame: CGRect(x: 0.0, y: 0.0, width: ratingView.frame.width, height: ratingView.frame.height))
        cp.strokeEnd = CGFloat((selectedModel?.voteAverage ?? 0.0) / 10)
        ratingView.addSubview(cp)
    }
    
    //setUp Models general info
    func loadModel(model: Result){
        nameLabel.text = model.title ?? model.name ?? model.originalName ?? model.originalTitle
        yearLabel.text = model.releaseDate ?? model.firstAirDate
        overviewLabel.text = model.overview
        model.posterPath?.downloadImage { (image) in
            DispatchQueue.main.async {
                self.moviewImageView.image = image
            }
        }
        
        model.backdropPath?.downloadImage { (image) in
            DispatchQueue.main.async {
                self.backgroundImageView.image = image
            }
        }
    }
    
    //load collection Views
    func loadCollectionViews(){
        
        seriesCastCollectionView.delegate = self
        seriesCastCollectionView.dataSource = self
        recommendationsCollectionView.delegate = self
        recommendationsCollectionView.dataSource = self
        
        let castCell = UINib(nibName: CastCell.identifier, bundle: nil)
        self.seriesCastCollectionView.register(castCell, forCellWithReuseIdentifier: CastCell.identifier)

        let recomCell = UINib(nibName: RecommendationsCell.identifier, bundle: nil)
        self.recommendationsCollectionView.register(recomCell, forCellWithReuseIdentifier: RecommendationsCell.identifier)
    }
    
    
    //MARK: cast info API
    func getCast(category: SubCategory, movieID: Int){
        var subCat = category
        if category == .Today || category == .ThisWeek{
            subCat = .Movie
            self.selectedSubC = .Movie
        }
        
        let url = "https://api.themoviedb.org/3/\(subCat.rawValue)/\(String(movieID))/credits?api_key=\(API_KEY)"
        APIServices.get(url: url, completion: { [self] (response: Cast) in
            for result in response.cast{
                self.cast.append(result)
            }
            
            DispatchQueue.main.async {
                self.seriesCastCollectionView.reloadData()
                if (self.cast.isEmpty && (category == .Today || category == .ThisWeek)){
                    print("repeat")
                    self.getCast(category: .TV, movieID: self.selectedModel!.id ?? 0)
                    self.selectedSubC = .TV
                }
            }
            
        })
    }
    
    //MARK: get recommendations API
    func getRecomendations(category: SubCategory, movieID: Int){
        var subCat = category
        if category == .Today || category == .ThisWeek{
            subCat = .Movie
        }
        
        let url = "https://api.themoviedb.org/3/\(subCat.rawValue)/\(movieID)/recommendations?api_key=\(API_KEY)&language=en-US&page=1"
        APIServices.get(url: url, completion: { (response: PopularTrandingModels) in
            for result in response.results{
                self.recommentations.append(result)
            }
            DispatchQueue.main.async {
                self.recommendationsCollectionView.reloadData()
                if (self.recommentations.isEmpty && (category == .Today || category == .ThisWeek)){
                    print("repeat")
                    self.getRecomendations(category: .TV, movieID: self.selectedModel!.id ?? 0)
                }
            }
            
        })
    }

}

//MARK: CollectionView
extension MovieViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == seriesCastCollectionView {
            return cast.count
        }
        return recommentations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let recomCell = recommendationsCollectionView.dequeueReusableCell(withReuseIdentifier: RecommendationsCell.identifier, for: indexPath) as! RecommendationsCell
        
        let seriesCell = seriesCastCollectionView.dequeueReusableCell(withReuseIdentifier: CastCell.identifier, for: indexPath) as! CastCell
        
        if collectionView == seriesCastCollectionView {
            let person = cast[indexPath.row]
            seriesCell.personNameLabel.text = person.name
            seriesCell.personCharacterLabel.text = person.character
            seriesCell.backgroundColor = .white
            person.profilePath?.downloadImage { (image) in
                DispatchQueue.main.async {
                    seriesCell.personImageView.image = image
                }
            }
            return seriesCell
        }
        let recom = recommentations[indexPath.row]
        recomCell.recommendationNameLabel.text = recom.name ?? recom.title ?? recom.originalName ?? recom.originalTitle
        recomCell.recommendationRatingLabel.text = "\(Int((recom.voteAverage ?? 0) * 10))%"
        recom.backdropPath?.downloadImage { (image) in
            DispatchQueue.main.async {
                recomCell.recommendationImageView.image = image
            }
        }
        return recomCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        //move to persons detail view Controller
        if collectionView == seriesCastCollectionView {
            performSegue(withIdentifier: PersonDetailViewController.segueIdendifier, sender: self)
        }
    }
    
    
}
