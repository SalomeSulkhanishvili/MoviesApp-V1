//
//  CastCell.swift
//  MoviesApp-V1
//
//  Created by ekaterine iremashvili on 10/12/20.
//

import UIKit

class CastCell: UICollectionViewCell {
    
    static let identifier = "CastCell"
    @IBOutlet weak var personImageView: UIImageView!
    @IBOutlet weak var personNameLabel: UILabel!
    @IBOutlet weak var personCharacterLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.layer.shadowColor = UIColor.lightGray.cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        contentView.layer.shadowRadius = 5.0
        contentView.layer.shadowOpacity = 2.0
        contentView.layer.masksToBounds = false
        contentView.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
        contentView.layer.backgroundColor = UIColor.clear.cgColor

        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 5
    }

}
