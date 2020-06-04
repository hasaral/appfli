//
//  Result.swift
//  appfli
//
//  Created by Hasan Saral on 2.06.2020.
//  Copyright © 2020 com.appfli. All rights reserved.
//

import Foundation

public enum Result<Value> {
    case success(Value)
    case failure(Error)
}
