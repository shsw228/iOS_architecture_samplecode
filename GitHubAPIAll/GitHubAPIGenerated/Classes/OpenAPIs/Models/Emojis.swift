//
// Emojis.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation



public struct Emojis: Codable {

    public var _100: String?
    public var _1234: String?
    public var _1: String?
    public var _1: String?
    public var _8ball: String?
    public var a: String?
    public var ab: String?

    public init(_100: String?, _1234: String?, _1: String?, _1: String?, _8ball: String?, a: String?, ab: String?) {
        self._100 = _100
        self._1234 = _1234
        self._1 = _1
        self._1 = _1
        self._8ball = _8ball
        self.a = a
        self.ab = ab
    }

    public enum CodingKeys: String, CodingKey { 
        case _100 = "100"
        case _1234 = "1234"
        case _1 = "+1"
        case _1 = "-1"
        case _8ball = "8ball"
        case a
        case ab
    }


}

