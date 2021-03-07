//
//  KeyedEncodingContainerProtocol+AdvancedCodableHelpers.swift
//  AdvancedCodableHelpers
//
//  Created by Tyler Anger on 2021-02-21.
//

import Foundation
import Nillable
import BasicCodableHelpers
import SwiftClassCollections

internal extension KeyedEncodingContainerProtocol where Key == CodableKey {
    /// Encode a dictionary to multiple keys in the given container
    ///
    /// - Parameters:
    ///   - dictionary: Any dictionary type where the Key is DictionaryKeyCodable and Value is Any where can cast to Encodable
    ///   - container: The container to encode to
    mutating func _encodeDictionary<D>(_ dictionary: D) throws where D: SDictionary, D.Key: DictionaryKeyCodable, D.Value == Any {
        for (key, v) in dictionary {
            if let dV = v as? Dictionary<String, Any> {
                try self.encodeDictionary(dV, forKey: key.dynamicCodingKey)
            } else if let dV = v as? Dictionary<Bool, Any> {
                try self.encodeDictionary(dV, forKey: key.dynamicCodingKey)
            } else if let dV = v as? Dictionary<Int, Any> {
                try self.encodeDictionary(dV, forKey: key.dynamicCodingKey)
            } else if let dV = v as? SCDictionary<String, Any> {
                try self.encodeDictionary(dV, forKey: key.dynamicCodingKey)
            } else if let dV = v as? SCDictionary<Int, Any> {
                try self.encodeDictionary(dV, forKey: key.dynamicCodingKey)
            } else if let dV = v as? SCArrayOrderedDictionary<String, Any> {
                try self.encodeDictionary(dV, forKey: key.dynamicCodingKey)
            } else if let dV = v as? SCArrayOrderedDictionary<Int, Any> {
                try self.encodeDictionary(dV, forKey: key.dynamicCodingKey)
            } else if let aV = v as? Array<Any> {
                try self._encodeArray(aV, forKey: key.dynamicCodingKey)
            } else if let aV = v as? SCArray<Any> {
                try self._encodeArray(aV, forKey: key.dynamicCodingKey)
            } else if let nV = v as? Nillable, nV.isNil {
                try self.encodeNil(forKey: key.dynamicCodingKey)
            } else if let eV = v as? Encodable {
                try eV.encode(to: self.superEncoder(forKey: key.dynamicCodingKey))
                //let wrappedEncoder = WrappedSingleValueEncoder(self.superEncoder(forKey: key.dynamicCodingKey).singleValueContainer())
                //try eV.encode(to: wrappedEncoder)
                /*let wrappedEncoder = WrappedUnKeyedEncoder(container.nestedUnkeyedContainer(forKey: key.dynamicCodingKey))
                try eV.encode(to: wrappedEncoder)
                let wrappedEncoder = WrappedKeyedEncoder(container)
                try eV.encode(to: wrappedEncoder)*/
            } else {
                let description = "Expected value to conform to Encodable but found \(type(of: v)) instead."
                throw EncodingError.invalidValue(v, EncodingError.Context(codingPath: self.codingPath.appending(key.dynamicCodingKey), debugDescription: description))
            }
        }
        
    }
}

public extension KeyedEncodingContainerProtocol {
    /// Encode a dictionary to a container
    ///
    /// - Parameters:
    ///   - dictionary: Any dictionary type where the Key is DictionaryKeyCodable and Value is Any where can cast to Encodable
    ///   - container: The container to encode to
    mutating func encodeDictionary<D>(_ dictionary: D,
                                      forKey key: Key) throws where D: SDictionary, D.Key: DictionaryKeyCodable, D.Value == Any {
        var container = self.nestedContainer(keyedBy: CodableKey.self, forKey: key)
        try container._encodeDictionary(dictionary)
        
        
    }
    
    /// Encode an optional dictionary to a container
    ///
    /// - Parameters:
    ///   - dictionary: Any dictionary type where the Key is DictionaryKeyCodable and Value is Any where can cast to Encodable
    ///   - container: The container to encode to
    ///   - key: The key in the container to encode the dictionary to
    @discardableResult
    mutating func encodeDictionaryIfPresent<D>(_ dictionary: D?,
                               forKey key: Key) throws -> Bool where D: SDictionary, D.Key: DictionaryKeyCodable, D.Value == Any {
        guard let d = dictionary else { return false }
        try self.encodeDictionary(d, forKey: key)
        return true
    }
    
    
}

public extension KeyedEncodingContainerProtocol {
    /// Encodes an array of Any to an UnkeyedEncodingContainer if possible
    ///
    /// Note: All objects within the array must implement the Encodable protocol
    ///
    /// - Parameters:
    ///   - array: The array of objects to encode
    ///   - container: The container to encode the objects to
    /// - Throws: EncodingError.invalidValue if the object can not encoded
    internal mutating func _encodeArray<S>(_ array: S,
                            forKey key: Key) throws where S: Sequence, S.Element == Any {
        var container = self.nestedUnkeyedContainer(forKey: key)
        
        for (i, v) in array.enumerated() {
            
            if let dV = v as? Dictionary<String, Any> {
                try container.encodeDictionary(dV)
            } else if let dV = v as? Dictionary<Bool, Any> {
                try container.encodeDictionary(dV)
            } else if let dV = v as? Dictionary<Int, Any> {
                try container.encodeDictionary(dV)
            } else if let dV = v as? SCDictionary<String, Any> {
                try container.encodeDictionary(dV)
            } else if let dV = v as? SCDictionary<Bool, Any> {
                try container.encodeDictionary(dV)
            } else if let dV = v as? SCDictionary<Int, Any> {
                try container.encodeDictionary(dV)
            } else if let dV = v as? SCArrayOrderedDictionary<String, Any> {
                try container.encodeDictionary(dV)
            } else if let dV = v as? SCArrayOrderedDictionary<Bool, Any> {
                try container.encodeDictionary(dV)
            } else if let dV = v as? SCArrayOrderedDictionary<Int, Any> {
                try container.encodeDictionary(dV)
            } else if let aV = v as? Array<Any> {
                try container._encodeArray(aV)
            } else if let aV = v as? SCArray<Any> {
                try container._encodeArray(aV)
            } else if let nV = v as? Nillable, nV.isNil {
                try container.encodeNil()
            } else if let eV = v as? Encodable {
                let wrappedEncoder = WrappedSingleValueEncoder(container.superEncoder().singleValueContainer())
                try eV.encode(to: wrappedEncoder)
                /*let wrappedEncoder = WrappedUnKeyedEncoder(container)
                 try eV.encode(to: wrappedEncoder)*/
            } else {
                let description = "Expected value to conform to Encodable but found \(type(of: v)) instead."
                throw EncodingError.invalidValue(v, EncodingError.Context(codingPath: container.codingPath.appending(index: i), debugDescription: description))
            }
        }
    }
    
    /// Encodes an array of Any to an UnkeyedEncodingContainer if possible
    ///
    /// Note: All objects within the array must implement the Encodable protocol
    ///
    /// - Parameters:
    ///   - array: The array of objects to encode
    ///   - container: The container to encode the objects to
    /// - Throws: EncodingError.invalidValue if the object can not encoded
    mutating func encode<S>(_ array: S,
                            forKey key: Key) throws where S: Sequence, S.Element == Any {
        return try self._encodeArray(array, forKey: key)
    }
    
    /// Encodes an array of Any to an UnkeyedEncodingContainer if possible
    ///
    /// Note: All objects within the array must implement the Encodable protocol
    ///
    /// - Parameters:
    ///   - array: The array of objects to encode
    /// - Throws: EncodingError.invalidValue if the object can not encoded
    @discardableResult
    mutating func encodeIfPresent<S>(_ array: S?,
                                     forKey key: Key) throws -> Bool where S: Sequence, S.Element == Any {
        guard let a = array else { return false }
        try self.encode(a, forKey: key)
        return true
    }
}


