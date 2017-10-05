//
//  BsonBinary+ExtendedJson.swift
//  ExtendedJson
//
//  Created by Jason Flax on 10/3/17.
//  Copyright © 2017 MongoDB. All rights reserved.
//

import Foundation

extension BsonBinary: ExtendedJsonRepresentable {
    public static func fromExtendedJson(xjson: Any) throws -> ExtendedJsonRepresentable {
        guard  let json = xjson as? [String : Any],
            let binaryJson = json[ExtendedJsonKeys.binary.rawValue] as? [String : String],
            let base64String = binaryJson["base64"],
            let typeString = binaryJson["subType"] else {
                throw BsonError.parseValueFailure(value: xjson, attemptedType: BsonBinary.self)
        }
        
        let fixedTypeString = typeString.hasHexadecimalPrefix() ? String(typeString.characters.dropFirst(2)) : typeString
        guard let data = Data(base64Encoded: base64String),
            let typeInt = UInt8(fixedTypeString, radix: 16),
            let type = BsonBinarySubType(rawValue: typeInt) else {
                throw BsonError.parseValueFailure(value: json, attemptedType: BsonBinary.self)
        }
        
        return BsonBinary(type: type, data: [UInt8](data))
    }

    public var toExtendedJson: Any {
        let base64String = Data(bytes: data).base64EncodedString()
        let type = String(self.type.rawValue, radix: 16)
        return [
            ExtendedJsonKeys.binary.rawValue : [
                "base64": base64String,
                "subType" : "0x\(type)"
            ]
        ]
    }
    
    public func isEqual(toOther other: ExtendedJsonRepresentable) -> Bool {
        if let other = other as? BsonBinary {
            return self == other
        }
        return false
    }
}