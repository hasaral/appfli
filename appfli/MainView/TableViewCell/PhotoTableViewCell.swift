//
//  PhotoTableViewCell.swift
//  appfli
//
//  Created by Hasan Saral on 2.06.2020.
//  Copyright © 2020 com.appfli. All rights reserved.
//

import UIKit
import Kingfisher

class PhotoTableViewCell: UITableViewCell {

    @IBOutlet var cellImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellImage.layer.cornerRadius = 10
        setupCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
    func cellConfig(photoData:Photo) {
        let id = photoData.id
        let owner = photoData.owner
        let secret = photoData.secret
        let server = photoData.server
        let farm = photoData.farm
        let title = photoData.title
        let ispublic = photoData.ispublic
        let isfriend = photoData.isfriend
        let isfamily = photoData.isfamily

        titleLabel.text = String(title.prefix(20))
         
        cellImage.kf.indicatorType = .activity
        
        var backdropUrlString: URL? {
            guard let farmid = farm as Int? else {
                print("nil")
                return URL(string:"1")
            }
            guard let serverid = server as String? else {
                print("nil")
                return URL(string:"2")
            }
            guard let photoid = id as String? else {
                print("nil")
                return URL(string:"49964613132")
            }
            guard let secretid = secret as String? else {
                print("nil")
                return URL(string:"dff2ed891f")
            }
            let farmId = Endpoints.getPhoto.secret.farmid
            let serverId = Endpoints.getPhoto.secret.serverid
            let photoId = Endpoints.getPhoto.secret.photoid
            let secretId = Endpoints.getPhoto.secret.secret
            let jpg = Endpoints.getPhoto.secret.jpg
            return URL(string: "\(farmId)\(farmid)\(serverId)\(serverid)\(photoId)\(photoid)\(secretId)\(secretid)\(jpg)")
        }
        
        cellImage.kf.setImage(with: backdropUrlString)
    }
    
    func setupCell() {
        cellImage.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        cellImage.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10).isActive = true
        cellImage.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 40).isActive = true
        cellImage.widthAnchor.constraint(equalToConstant: 50).isActive = true
        cellImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        titleLabel.leftAnchor.constraint(equalTo: cellImage.rightAnchor,constant: 20).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -10).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant:20).isActive = true
        
    }
}

