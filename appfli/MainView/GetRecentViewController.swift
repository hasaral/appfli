//
//  GetRecentViewController.swift
//  appfli
//
//  Created by Hasan Saral on 1.06.2020.
//  Copyright © 2020 com.appfli. All rights reserved.
//

import UIKit
import Kingfisher

class GetRecentViewController: UIViewController {

    var viewModel: ListPageViewModelProtocol! {
        didSet {
            guard let viewModel = viewModel else { return }
            viewModel.delegate = self
        }
    }
    private var photoList: [Photo] = []
    private var photoListUp: [Photo] = []

    @IBOutlet var tableView: UITableView!
    var cell:PhotoTableViewCell?
    var dataFlag:Bool = false
    var updateFlag:Bool = false
    var countFlag:Bool = false

    var perpage:Int?
    var page:Int?
    var uPerpage:Int = 0
    var uPage:Int = 0
    var total:Int?
    var rowNumber:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.getPageList()
        showActivityIndicator()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

extension GetRecentViewController: ListPageViewModelDelegate {
    func handleViewModelOutPut(_ output: ListPageViewModelOutput) {
        switch output {
        case .getPageList(let photos):
            perpage = photos.perpage
            page = photos.pages
            total = photos.total
            self.photoList = []
            viewModel.getPage(perpage: total!, page: 1)
      
        case .getPage(let photo):
            
            self.photoListUp.append(contentsOf: photo)
            self.photoList.append(contentsOf: photo)
        
            let arraySlice = self.photoList.prefix(upTo: 20)
            self.photoList = Array(arraySlice)
            
    //FOR SERVICE
//            if uPerpage >= total! {
//                self.photoList = self.photoListUp
//                let arraySlice = self.photoList.prefix(upTo: total!)
//                self.photoList = Array(arraySlice)
//            } else {
//                if  countFlag {
//                    self.photoList = self.photoListUp
//                    let arraySlice = self.photoList.prefix(upTo: uPerpage)
//                    self.photoList = Array(arraySlice)
//                } else {
//                    self.photoList.append(contentsOf: photo)
//                    let arraySlice = self.photoList.prefix(upTo: 20)
//                    self.photoList = Array(arraySlice)
//                }
//
                hideActivityIndicator()
                dataFlag = true
                tableView.reloadData()
//            }
        }
    }
}

extension GetRecentViewController:TableviewViewProtocols {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataFlag {
            return photoList.count
        } else {
            return 0
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
            cell = (Bundle.main.loadNibNamed("PhotoTableViewCell", owner: self, options: nil)?.first as! PhotoTableViewCell)
            cell!.selectionStyle = .none
            cell!.cellConfig(photoData: photoList[indexPath.row])
            rowNumber = indexPath.row

            return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 60
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == tableView {
        
            let offsetY = scrollView.contentOffset.y
            let contentH = scrollView.contentSize.height
      
            if offsetY > contentH - scrollView.frame.height  {
                uPerpage += 20
                let countArray = self.photoListUp.shuffled
                let count = countArray().prefix(uPerpage)
                self.photoList.append(contentsOf: count)
                self.tableView.showsVerticalScrollIndicator = true
                print("1",count.count)
                print("2",uPerpage)
                self.tableView.reloadData()
    //FOR SERVICE
//                    if  !updateFlag {
//                        beginUpdate()
//
//                    }
                }
            }
        }
    
    //FOR SERVICE
//    func beginUpdate() {
//        countFlag = true
//        updateFlag = true
//         DispatchQueue.main.asyncAfter(deadline: .now() + 0.30) {
//            if self.uPerpage > self.total! / 2 {
//                self.uPerpage += 20
//                self.uPage = 2
//                self.viewModel.getPage(perpage: self.total!, page: self.uPage)
//                self.updateFlag = false
//
//            } else if self.uPerpage <= self.total! {
//                self.uPage = 1
//                self.uPerpage += 20
//                self.viewModel.getPage(perpage: self.total!, page: self.uPage)
//                self.updateFlag = false
//
//            } else {
//                self.photoList = self.photoListUp
//                let arraySlice = self.photoList.prefix(upTo: self.total!)
//                self.photoList = Array(arraySlice)
//                self.tableView.reloadData()
//            }
//        }
//    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
   
        if scrollView == tableView {
            let firstIndex = (tableView.indexPathsForVisibleRows?.first?.row)!

            let indexPaths = IndexPath(row: firstIndex, section: 0)
            self.tableView.scrollToRow(at: indexPaths, at: .top, animated: true)

        }
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

            let storyBoard: UIStoryboard = UIStoryboard(name: "Detail", bundle: nil)
            let viewController = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
            viewController.farm = self.photoList[indexPath.row].farm
            viewController.id = self.photoList[indexPath.row].id
            viewController.server = self.photoList[indexPath.row].server
            viewController.secret = self.photoList[indexPath.row].secret
            viewController.titles = self.photoList[indexPath.row].title

            self.navigationController?.pushViewController(viewController, animated: true)
    
    }
}
