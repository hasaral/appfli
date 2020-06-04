//
//  BaseUrl.swift
//  appfli
//
//  Created by Hasan Saral on 1.06.2020.
//  Copyright © 2020 com.appfli. All rights reserved.
//

import Foundation


struct BaseUrl {
    static let appKey = "065be7ab3a181e44b2b3d31d60d31384"
    static let baseUrl = "https://www.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=\(appKey)&per_page=&page=&format=json&nojsoncallback=1"
}
