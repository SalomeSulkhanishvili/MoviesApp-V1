//
//  ViewController.swift
//  MoviesApp-V1
//
//  Created by ekaterine iremashvili on 10/8/20.
//

import UIKit

class MainPageViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var popularMovies = [Result]()
    var trendingMovies = [Result]()
    let API_KEY = "d3fa10fb0c4c3a7403643860403c2935"
    var popularC: SubCategory = .TV
    var trendingC: SubCategory = .Today
    var selectedModel : Result?
    var selectedCategory: GeneralCategory?
    var selectedSubC: SubCategory?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        notifications()
        loadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier, id == "detail_move_page" {
            if let movieVC = segue.destination as? MovieViewController{
                movieVC.selectedModel = self.selectedModel
                movieVC.selectedCategory = self.selectedCategory
                movieVC.selectedSubC = self.selectedSubC
            }
        }
    }
    //move to favorite page
    @IBAction func onFavorite(_ sender: UIButton) {
        performSegue(withIdentifier: "favorite_segue", sender: nil)
    }
    
    //MARK: get tranding API
    func getTranding(){
        trendingMovies.removeAll()
        let url = "https://api.themoviedb.org/3/trending/all/day?api_key=\(API_KEY)&fbclid=IwAR2LS9USY2OU74DWcXyc-mndfQ8YOu_4H8dFTgDC3XqPc8XS66A9xTf2GJA"
        APIServices.get(url: url, completion: { (response: PopularTrandingModels) in
            for result in response.results{
                print(result)
            }
        })
    }
    
    //MARK: get movie api
    func getCategory(category: GeneralCategory, subC: SubCategory){
        //if category is popular get popular api
        if category == .Popular {
            popularMovies.removeAll()
            let url = "https://api.themoviedb.org/3/\(subC.rawValue)/popular?api_key=\(API_KEY)&language=en-US&page=2"
            APIServices.get(url: url, completion: { (response: PopularTrandingModels) in
                for result in response.results{
                    self.popularMovies.append(result)
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            })
            //if category is trending get trending api
        }else if category == .Trending {
            trendingMovies.removeAll()
            let url = "https://api.themoviedb.org/3/trending/all/\(subC.rawValue)?api_key=\(API_KEY)&fbclid=IwAR2LS9USY2OU74DWcXyc-mndfQ8YOu_4H8dFTgDC3XqPc8XS66A9xTf2GJA"
            APIServices.get(url: url, completion: { (response: PopularTrandingModels) in
                for result in response.results{
                    self.trendingMovies.append(result)
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }

            })
        }

    }
    
    //MARK: Notifications
    func notifications(){
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(changeSubCategory(with:)),
            name: .changeSubCategoryChannelID,
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(moveToDetailPage(with:)),
            name: .moveToMovieDetailChannelID,
            object: nil)
    }
    
    @objc func changeSubCategory(with notification: Notification){
        if let info = notification.userInfo{
            let category = info["category"] as! GeneralCategory
            let subC = info["sub category"] as! SubCategory
            changeCat(category, subC)
        }
    }
    
    @objc func moveToDetailPage(with notification: Notification){
        if let info = notification.userInfo{
            selectedCategory = info["category"] as? GeneralCategory
            selectedSubC = info["sub category"] as? SubCategory
            selectedModel = info["model"] as? Result
            
            performSegue(withIdentifier: "detail_move_page", sender: nil)
        }
    }
    
    //input general category and sub Category
    //
    func changeCat(_ category: GeneralCategory, _ subC: SubCategory){
        if category == .Popular{
            if subC == .Movie {
                popularC = .TV
                getCategory(category: category, subC: popularC)
            }else if subC == .TV {
                popularC = .Movie
                getCategory(category: category, subC: popularC)
            }
        }else if category == .Trending{
            if subC == .Today {
                trendingC = .ThisWeek
                getCategory(category: category, subC: trendingC)
                
            }else if subC == .ThisWeek {
                trendingC = .Today
                getCategory(category: category, subC: trendingC)
                
            }
        }
    }
    
    //loads popular and trending api for the first time
    func loadData(){
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        //load tv
        let url = "https://api.themoviedb.org/3/tv/popular?api_key=\(API_KEY)&language=en-US&page=2"
        APIServices.get(url: url, completion: { (response: PopularTrandingModels) in
            for result in response.results{
                //print(result)
                self.popularMovies.append(result)
            }
            DispatchQueue.main.async {
                dispatchGroup.leave()
            }
        })
        
        dispatchGroup.enter()
        //load tranding today
        let Trandingurl = "https://api.themoviedb.org/3/trending/all/day?api_key=\(API_KEY)&fbclid=IwAR2LS9USY2OU74DWcXyc-mndfQ8YOu_4H8dFTgDC3XqPc8XS66A9xTf2GJA"
        APIServices.get(url: Trandingurl, completion: { (response: PopularTrandingModels) in
            for result in response.results{
                //print(result)
                self.trendingMovies.append(result)
            }
            
            DispatchQueue.main.async {
                dispatchGroup.leave()
            }

        })
        
        dispatchGroup.notify(queue: .main, execute: {
            print("load data")
            self.tableView.reloadData()
        })
        
    }
    

}

//MARK: tableView
extension MainPageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let headerCell = tableView.dequeueReusableCell(withIdentifier: HeaderCell.identifier, for: indexPath) as! HeaderCell
        let movieCell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
        
        if indexPath.row == 0 {
             return headerCell
        }else if indexPath.row == 1 {
            movieCell.titleLabel.text = "What's Popular"
            movieCell.categoryController.setTitle("On TV", forSegmentAt: 0)
            movieCell.categoryController.setTitle("In Theater", forSegmentAt: 1)
            movieCell.categoryController.selectedSegmentIndex = (popularC == .TV) ? 0 : 1
            movieCell.generalC = .Popular
            movieCell.subC = popularC
            movieCell.setData(data: popularMovies)
            
        }else if indexPath.row == 2 {
            movieCell.titleLabel.text = "Trending"
            movieCell.categoryController.setTitle("Today", forSegmentAt: 0)
            movieCell.categoryController.setTitle("This Week", forSegmentAt: 1)
            movieCell.generalC = .Trending
            movieCell.categoryController.selectedSegmentIndex = (trendingC == .Today) ? 0 : 1
            movieCell.subC = trendingC
            movieCell.setData(data: trendingMovies)
        }
        
        return movieCell
    }
    
    
}

