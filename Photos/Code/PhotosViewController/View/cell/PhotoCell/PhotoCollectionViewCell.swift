//
//  PhotoCollectionViewCell.swift
//  Photos
//
//  Created by Kanan Abilzada on 30.11.21.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    var item: PhotoListModel?
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.center = self.contentView.center
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    static let identifier = "PhotoCollectionViewCell"

    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.contentView.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
    }
    
    static func nib() -> UINib {
        return UINib(nibName: identifier,
                     bundle: Bundle.main)
    }

}
