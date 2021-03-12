//
//  ContainedCodableArray.swift
//  AdvancedCodableHelpers
//
//  Created by Tyler Anger on 2021-02-22.
//

import Foundation
import SwiftClassCollections

/// A wrpper around a sequence of elements to encode
internal struct ContainedCodableArray<S>: Codable where S: SArray, S.Element == Any {
    public let array: S
    public init(_ s: S) { self.array = s }
    
    public init(from decoder: Decoder) throws {
        let a: Array<Any>!
        let container = try decoder.singleValueContainer()
        if let f = decoder.userInfo[.customDecoding],
           let customDecoding = f as? ((_ decoder: Decoder) throws -> Any?) {
            //a = try CodableHelpers.arrays.decode(from: decoder, customDecoding: customDecoding)
            a = try container.decodeAnyArray(customDecoding: customDecoding)
        } else {
            //a = try CodableHelpers.arrays.decode(from: decoder)
            a = try container.decodeAnyArray()
        }
        if S.self == Array<Any>.self { self.array = a as! S }
        else { self.array = S(a) }
    }
    
    public func encode(to encoder: Encoder) throws {
        //try CodableHelpers.arrays.encode(self.array, to: encoder)
        var container = encoder.singleValueContainer()
        try container.encode(self.array)
    }
    
}
