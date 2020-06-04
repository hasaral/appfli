//
//  Photo.swift
//  appfli
//
//  Created by Hasan Saral on 1.06.2020.
//  Copyright © 2020 com.appfli. All rights reserved.


import UIKit
import Foundation

struct PhotoResponse: Codable {
    let photos: Photos
    let stat: String
}

extension PhotoResponse {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(PhotoResponse.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        photos: Photos? = nil,
        stat: String? = nil
        ) -> PhotoResponse {
        return PhotoResponse(
            photos: photos ?? self.photos,
            stat: stat ?? self.stat
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

struct Photos: Codable {
    let page, pages, perpage, total: Int
    let photo: [Photo]
}

extension Photos {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Photos.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        page: Int? = nil,
        pages: Int? = nil,
        perpage: Int? = nil,
        total: Int? = nil,
        photo: [Photo]? = nil
        ) -> Photos {
        return Photos(
            page: page ?? self.page,
            pages: pages ?? self.pages,
            perpage: perpage ?? self.perpage,
            total: total ?? self.total,
            photo: photo ?? self.photo
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

struct Photo: Codable, Hashable {
    let id, owner, secret, server: String
    let farm: Int
    let title: String
    let ispublic, isfriend, isfamily: Int
}

extension Photo {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Photo.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        id: String? = nil,
        owner: String? = nil,
        secret: String? = nil,
        server: String? = nil,
        farm: Int? = nil,
        title: String? = nil,
        ispublic: Int? = nil,
        isfriend: Int? = nil,
        isfamily: Int? = nil
        ) -> Photo {
        return Photo(
            id: id ?? self.id,
            owner: owner ?? self.owner,
            secret: secret ?? self.secret,
            server: server ?? self.server,
            farm: farm ?? self.farm,
            title: title ?? self.title,
            ispublic: ispublic ?? self.ispublic,
            isfriend: isfriend ?? self.isfriend,
            isfamily: isfamily ?? self.isfamily
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}
