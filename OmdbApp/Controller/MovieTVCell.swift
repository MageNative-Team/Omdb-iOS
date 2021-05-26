//
//  MovieTVCell.swift
//  OmdbApp
//
//  Created by cedcoss on 25/05/21.
//

import UIKit
import SDWebImage

class MovieTVCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var imdbID: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var year: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle                     = .none
        self.containerView.layer.cornerRadius   = 10.0
        self.contentView.backgroundColor        = dynamicColor.secondarySystemBackground
        title.textColor                         = dynamicColor.secondaryLabel
        title.textColor                         = dynamicColor.label
        imdbID.textColor                        = dynamicColor.label
        type.textColor                          = dynamicColor.label
        year.textColor                          = dynamicColor.label
    }
    
    func configure(with movieData: SearchDataModel? ){
        guard let url   = URL(string: movieData?.poster ?? "") else {return}
        poster.sd_setImage(with: url, placeholderImage: UIImage(named:"placeholder"))
        title.text      = movieData?.title ?? "NA"
        imdbID.text     = ""
        type.text       = movieData?.type?.uppercased() ?? "NA"
        year.text       = movieData?.year ?? "NA"
        self.containerView.backgroundColor = AppSetUp.shared.getColor(str: movieData?.title ?? "NA")
    }
}
