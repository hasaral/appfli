//
//  Decoder.swift
//  appfli
//
//  Created by Hasan Saral on 2.06.2020.
//  Copyright © 2020 com.appfli. All rights reserved.
//

import Foundation

public enum Decoders {
    public static let plainDateDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }()
}
