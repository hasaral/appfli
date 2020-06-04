//
//  ListPageContracts.swift
//  appfli
//
//  Created by Hasan Saral on 1.06.2020.
//  Copyright © 2020 com.appfli. All rights reserved.
//

import Foundation

protocol ListPageViewModelProtocol: class {
    var delegate: ListPageViewModelDelegate! { get set }
    func getPageList()
    func getPage(perpage:Int, page:Int)
    func notifyController(_ output: ListPageViewModelOutput)
    
}

protocol ListPageViewModelDelegate: class {
    func handleViewModelOutPut(_ output: ListPageViewModelOutput)
    
}

enum ListPageViewModelOutput {
    case getPageList(photos: Photos)
    case getPage(photos: [Photo])
    
}

