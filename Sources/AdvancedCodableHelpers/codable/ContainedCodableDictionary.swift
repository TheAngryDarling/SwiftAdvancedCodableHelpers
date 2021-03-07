//
//  ContainedCodableDictionary.swift
//  AdvancedCodableHelpers
//
//  Created by Tyler Anger on 2021-02-22.
//

import Foundation
import SwiftClassCollections

internal struct ContainedCodableDictionary<D>: Codable where D: ReEncapsulatableDictionary, D.Key: DictionaryKeyCodable, D.Value == Any {
    public let dictionary: D
    public init(_ d: D) { self.dictionary = d }
    
    public init(from decoder: Decoder) throws {
        var customDecoding: (_ decoder: Decoder) throws -> Any? = { _ in return nil }
        
        if let f = decoder.userInfo[.customDecoding], let cF = f as? ((_ decoder: Decoder) throws -> Any?) {
            customDecoding = cF
        }
        var excludingKeys: [CodableKey] = []
        if let f = decoder.userInfo[.excludingKeys], let cF = f as? [CodableKey] {
            excludingKeys = cF
        } else if let f = decoder.userInfo[.excludingKeys], let cF = f as? [D.Key] {
            excludingKeys = cF.map({ return $0.dynamicCodingKey })
        }
        
        let container = try decoder.container(keyedBy: CodableKey.self)
        let d: SCArrayOrderedDictionary<D.Key, D.Value> = try container.decodeAndRemapDictionary(excludingKeys: excludingKeys,
                                        customDecoding: customDecoding)
        
        self.dictionary = d.reencapsulate(dictionariesTo: D.ReEncapsulateType, arraysTo: .array) as! D
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodableKey.self)
        try container._encodeDictionary(self.dictionary)
    }
    
}
