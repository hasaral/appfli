//
//  EndPoint.swift
//  appfli
//
//  Created by Hasan Saral on 1.06.2020.
//  Copyright © 2020 com.appfli. All rights reserved.
//

import Foundation

import UIKit


fileprivate protocol Endpoint {
  
    var value: String { get }
}

enum Endpoints {
    fileprivate static var baseUrl: String { return "\(BaseUrl.baseUrl)" }
    
    enum getRecent:Endpoint {
      
        case getRecent
        
        var value: String {
            switch self {
            case .getRecent: return "\(BaseUrl.baseUrl)"
            }
        }
    }
    
    enum updateRecent:Endpoint {
        
        internal var perpage: String { return "&per_page="}
        internal var page: String { return "page="}
        internal var format: String { return "&format=json&nojsoncallback=1"}
 
        case updateRecent
        
        var value: String {
            switch self {
            case .updateRecent: return "https://www.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=\(BaseUrl.appKey)"
            }
        }
    }
 
    enum getPhoto: Endpoint {
     
        internal var farmid: String { return "https://farm"}
        internal var serverid: String { return ".staticflickr.com/"}
        internal var photoid: String { return "/"}
        internal var secret: String { return "_"}
        internal var jpg: String { return ".jpg"}
        
        case secret

        var value: String {
            switch self {
            case .secret:
                return ""
            }
        }
    }
}

