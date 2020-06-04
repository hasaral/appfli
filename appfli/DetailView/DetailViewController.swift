//
//  DetailViewController.swift
//  appfli
//
//  Created by Hasan Saral on 3.06.2020.
//  Copyright © 2020 com.appfli. All rights reserved.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    
    var id = ""
    var secret = ""
    var server = ""
    var farm = 0
    var titles = ""
 
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = titles
        
        imageView.kf.indicatorType = .activity

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
        
        imageView.kf.setImage(with: backdropUrlString)

    }
}
