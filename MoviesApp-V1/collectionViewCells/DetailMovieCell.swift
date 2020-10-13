//
//  DetailMovieCell.swift
//  MoviesApp-V1
//
//  Created by ekaterine iremashvili on 10/8/20.
//

import UIKit

class DetailMovieCell: UICollectionViewCell {
    static var identifier = "DetailMovieCell"
    
    @IBOutlet weak var MovieImageView: UIImageView!
    @IBOutlet weak var RatingView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var movieModel: Result! {
        didSet{
            titleLabel.text = movieModel.title ?? movieModel.name ?? movieModel.originalName ?? movieModel.originalTitle
            dateLabel.text = movieModel.releaseDate ?? movieModel.firstAirDate
            movieModel.posterPath?.downloadImage { (image) in
                DispatchQueue.main.async {
                    self.MovieImageView.image = image
                }
            }
            RatingView.backgroundColor = .clear
            let cp = CircularProgressView(frame: CGRect(x: 0.0, y: 0.0, width: RatingView.frame.width, height: RatingView.frame.height))
            cp.strokeEnd = CGFloat((movieModel.voteAverage ?? 0.0) / 10)
            RatingView.addSubview(cp)
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        RatingView.layer.cornerRadius = RatingView.frame.height / 2
        MovieImageView.clipsToBounds = true
        MovieImageView.layer.cornerRadius = 10
    }

}
