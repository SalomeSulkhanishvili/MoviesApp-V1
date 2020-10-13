//
//  HeaderCell.swift
//  MoviesApp-V1
//
//  Created by ekaterine iremashvili on 10/8/20.
//

import UIKit

class HeaderCell: UITableViewCell {
    static var identifier = "HeaderCell"

    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func onSearch(_ sender: UIButton) {
        print("search");
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        searchButton.layer.cornerRadius = searchButton.frame.height / 2
        searchTextField.layer.cornerRadius = searchTextField.frame.height / 2
        searchTextField.clipsToBounds = true
        if #available(iOS 11.0, *) {
            searchTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        } else {
            // Fallback on earlier versions
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
