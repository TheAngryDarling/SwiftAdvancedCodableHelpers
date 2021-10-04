//
//  SingleValueEncodingContainer+AdvancedCodableHelpers.swift
//  AdvancedCodableHelpers
//
//  Created by Tyler Anger on 2021-02-21.
//

import Foundation
import Nillable
import BasicCodableHelpers
import SwiftClassCollections

public extension SingleValueEncodingContainer {
    /// Provides access to a KeyedDecodingContainer for the given SingleValueDecodingContainer
    mutating fileprivate func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type,
                                                block: @escaping (inout KeyedEncodingContainer<NestedKey>) throws -> Void) throws {
        try self.encode(KeyedEncodingContainerCatcher(keyType: keyType, block: block))
    }
    
    
    /// Provides access to a KeyedDecodingContainer for the given SingleValueDecodingContainer
    mutating fileprivate func nestedUnkeyedContainer(block: @escaping (inout UnkeyedEncodingContainer) throws -> Void) throws -> Void {
        //try self.encode(UnkeyedEncoderHelper(block: block))
        try self.encode(UnkeyedEncodingContainerCatcher(block: block))
    }
    
}

public extension SingleValueEncodingContainer {
    /// Encode a dictionary to a container
    ///
    /// - Parameters:
    ///   - dictionary: Any dictionary type where the Key is DictionaryKeyCodable and Value is Any where can cast to Encodable
    ///   - container: The container to encode to
    mutating func encodeAnyDictionary<D>(_ dictionary: D) throws where D: SDictionary, D.Key: DictionaryKeyCodable, D.Value == Any {
        //var container = self.nestedContainer(keyedBy: CodableKey.self)
        try self.nestedContainer(keyedBy: CodableKey.self) { container in
            try container._encodeAnyDictionary(dictionary)
        }
        
    }
    
    /// Encode an optional dictionary to a container
    ///
    /// - Parameters:
    ///   - dictionary: Any dictionary type where the Key is DictionaryKeyCodable and Value is Any where can cast to Encodable
    /// - Returns: Returns a bool indicator if an object was encoded or not
    @discardableResult
    mutating func encodeAnyDictionaryIfPresent<D>(_ dictionary: D?) throws -> Bool where D: SDictionary, D.Key: DictionaryKeyCodable, D.Value == Any {
        guard let d = dictionary else { return false }
        try self.encodeAnyDictionary(d)
        return true
    }
    
    
}

public extension SingleValueEncodingContainer {
    
    /// Encodes an array of Any to the container
    ///
    /// Note: All objects within the array must implement the Encodable protocol
    ///
    /// - Parameters:
    ///   - array: The array of objects to encode
    /// - Throws: EncodingError.invalidValue if the object can not encoded
    mutating func encode<S>(_ array: S) throws where S: Sequence, S.Element == Any {
        try self.nestedUnkeyedContainer { container in
            try container._encodeAnyArray(array)
        }
    }
    
    /// Encodes an array of Any to an UnkeyedEncodingContainer if possible
    ///
    /// Note: All objects within the array must implement the Encodable protocol
    ///
    /// - Parameters:
    ///   - array: The array of objects to encode
    /// - Returns: Returns an indicator if the object was encoded or not   
    /// - Throws: EncodingError.invalidValue if the object can not encoded
    @discardableResult
    mutating func encodeIfPresent<S>(_ array: S?) throws -> Bool where S: Sequence, S.Element == Any {
        guard let a = array else { return false }
        try self.encode(a)
        return true
    }
}
