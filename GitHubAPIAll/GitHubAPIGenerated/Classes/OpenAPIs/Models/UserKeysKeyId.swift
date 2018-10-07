//
// UserKeysKeyId.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation



public struct UserKeysKeyId: Codable {

    public var _id: Int?
    public var key: String?
    public var title: String?
    public var url: String?

    public init(_id: Int?, key: String?, title: String?, url: String?) {
        self._id = _id
        self.key = key
        self.title = title
        self.url = url
    }

    public enum CodingKeys: String, CodingKey { 
        case _id = "id"
        case key
        case title
        case url
    }


}

