//
//  RecommendationsCell.swift
//  MoviesApp-V1
//
//  Created by ekaterine iremashvili on 10/9/20.
//

import UIKit

class RecommendationsCell: UICollectionViewCell {
    
    static let identifier = "RecommendationsCell"
    
    @IBOutlet weak var recommendationImageView: UIImageView!
    @IBOutlet weak var recommendationNameLabel: UILabel!
    @IBOutlet weak var recommendationRatingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        superview?.layoutSubviews()
        
        recommendationImageView.layer.cornerRadius = 5
    }

}
