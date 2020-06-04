//
//  ListPageViewModel.swift
//  appfli
//
//  Created by Hasan Saral on 1.06.2020.
//  Copyright © 2020 com.appfli. All rights reserved.
//


import Foundation

final class ListPageViewModel: ListPageViewModelProtocol {
 
    var service: ListServiceProtocol!
    var delegate: ListPageViewModelDelegate!
    
    init(service: ListService = ListService()) {
        self.service = service
        
    }
    
    private var pageList: Photos?

    private var photoList: [Photo] = []
    
    func getPageList() {
        
        service.fetchRecentPhoto { [weak self] result in
            
            guard let `self` = self else {return}
            switch result {
            case .success(let value):
                self.pageList = value.photos
                
                self.notifyController(.getPageList(photos: self.pageList!))
                
            case.failure(let error):
                print(error)
            }
        }
    }
    
    func getPage(perpage:Int, page:Int) {
        
        service.updateRecentPhoto(perpage: perpage, page: page) { [weak self] result in
            
            guard let `self` = self else {return}
            switch result {
            case .success(let value):
                self.photoList = value.photos.photo

                self.notifyController(.getPage(photos: self.photoList))
                
            case.failure(let error):
                print(error)
            }
        }
    }
    

    func notifyController(_ output: ListPageViewModelOutput) {
        delegate.handleViewModelOutPut(output)
    }
}

