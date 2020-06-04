//
//  MainPageBuilder.swift
//  appfli
//
//  Created by Hasan Saral on 1.06.2020.
//  Copyright © 2020 com.appfli. All rights reserved.
//

import Foundation
import UIKit

final class HomePageBuilder {
    static func make() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "GetRecentViewController") as! GetRecentViewController
        viewController.viewModel =  ListPageViewModel(service: app.service)
        return viewController
        
    }
}
