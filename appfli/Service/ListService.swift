//
//  ListService.swift
//  appfli
//
//  Created by Hasan Saral on 1.06.2020.
//  Copyright © 2020 com.appfli. All rights reserved.
//

import Foundation
import Alamofire


protocol ListServiceProtocol {
    
    func fetchRecentPhoto(completion: @escaping (Result<PhotoResponse>) -> Void)
    func updateRecentPhoto(perpage:Int, page:Int, completion: @escaping (Result<PhotoResponse>) -> Void)
}

class ListService: ListServiceProtocol {
 
    public enum Error: Swift.Error {
        case serializationError(internal: Swift.Error)
        case networkError(internal: Swift.Error)
    }
    
    func fetchRecentPhoto(completion: @escaping (Result<PhotoResponse>) -> Void) {
        
        let urlString = Endpoints.getRecent.getRecent.value
      
        request(urlString).responseData {(response) in
            switch response.result {
            case .success(let data):
    
                let decoder = Decoders.plainDateDecoder
                do {

                    let response = try decoder.decode(PhotoResponse.self, from: data)
                    completion(.success(response))

                } catch {
                    completion(.failure(Error.serializationError(internal: error)))
                }
            case .failure(let error):
                completion(.failure(Error.networkError(internal: error)))
            }
        }
    }
    
    func updateRecentPhoto(perpage:Int, page:Int, completion: @escaping (Result<PhotoResponse>) -> Void) {
        
        var pageUrlString: URL? {
            guard let perpage = perpage as Int? else {
                print("nil")
                return URL(string:"20")
            }
            guard let page = page as Int? else {
                print("nil")
                return URL(string:"1")
            }
            
            let base = Endpoints.updateRecent.updateRecent.value
            let per_page = Endpoints.updateRecent.updateRecent.perpage
            let page_ = Endpoints.updateRecent.updateRecent.page
            let format = Endpoints.updateRecent.updateRecent.format
           
            return URL(string: "\(base)\(per_page)\(perpage)\(page_)\(page)\(format)")
        }
        
        request(pageUrlString!).responseData {(response) in
            switch response.result {
            case .success(let data):
                
                let decoder = Decoders.plainDateDecoder
                do {
                    
                    let response = try decoder.decode(PhotoResponse.self, from: data)
                    completion(.success(response))
                    
                } catch {
                    completion(.failure(Error.serializationError(internal: error)))
                }
            case .failure(let error):
                completion(.failure(Error.networkError(internal: error)))
            }
        }
    }
}

