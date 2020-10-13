//
//  FavoriteCell.swift
//  MoviesApp-V1
//
//  Created by ekaterine iremashvili on 10/13/20.
//

import UIKit

class FavoriteCell: UICollectionViewCell {
    
    static var identifier = "FavoriteCell"

    @IBOutlet weak var modelImageView: UIImageView!
    @IBOutlet weak var modelView: UIView!
    @IBOutlet weak var modelNameLabel: UILabel!
    @IBOutlet weak var modelDateLabel: UILabel!
    
    let darkBlue = UIColor(red: 13.0/255.0, green: 37.0/255.0, blue: 63.0/255.0, alpha: 1.0)

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    
        modelImageView.clipsToBounds = true
        modelView.clipsToBounds = true
        modelImageView.layer.cornerRadius = 10
        modelView.layer.cornerRadius = 10
        modelView.gradient(firstColor: darkBlue, secondColor: UIColor.clear)
        
        
        
    }

}
