//
//  PersonDetailViewController.swift
//  MoviesApp-V1
//
//  Created by ekaterine iremashvili on 10/12/20.
//

import UIKit

class PersonDetailViewController: UIViewController {
    
    @IBOutlet weak var personNameLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var placeOfBirthLabel: UILabel!
    @IBOutlet weak var biographyLabel: UILabel!
    @IBOutlet weak var personImageView: UIImageView!
    static let segueIdendifier = "peson_detail_id"
    let API_KEY = "d3fa10fb0c4c3a7403643860403c2935"
    var selectedPerson: CastElement?
    var person: PersonInfo?

    override func viewDidLoad() {
        super.viewDidLoad()
        getPersonInfo(person_ID: selectedPerson?.id ?? 0)
        personImageView.layer.cornerRadius = 5
    }
    
    //MARK: person info api
    func getPersonInfo(person_ID: Int){
        let url = "https://api.themoviedb.org/3/person/\(person_ID)?api_key=\(API_KEY)&language=en-US"
        APIServices.get(url: url, completion: { (response: PersonInfo) in
            self.person = response
            
            DispatchQueue.main.async {
                self.loadInfo()
            }
        })
    }
    
    //set up persons general info
    func loadInfo(){
        personNameLabel.text = person?.name
        birthdayLabel.text = person?.birthday
        placeOfBirthLabel.text = person?.placeOfBirth
        biographyLabel.text = person?.biography
        
        person?.profilePath?.downloadImage { (image) in
            DispatchQueue.main.async {
                self.personImageView.image = image
            }
        }
    }

}
