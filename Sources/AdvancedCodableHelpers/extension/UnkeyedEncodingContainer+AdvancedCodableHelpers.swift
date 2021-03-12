//
//  UnkeyedEncodingContainer+AdvancedCodableHelpers.swift
//  AdvancedCodableHelpers
//
//  Created by Tyler Anger on 2021-02-21.
//

import Foundation
import Nillable
import BasicCodableHelpers
import SwiftClassCollections

public extension UnkeyedEncodingContainer {
    /// Encode a dictionary to a container
    ///
    /// - Parameters:
    ///   - dictionary: Any dictionary type where the Key is DictionaryKeyCodable and Value is Any where can cast to Encodable
    ///   - container: The container to encode to
    mutating func encodeAnyDictionary<D>(_ dictionary: D) throws where D: SDictionary, D.Key: DictionaryKeyCodable, D.Value == Any {
        var container = self.nestedContainer(keyedBy: CodableKey.self)
        try container._encodeAnyDictionary(dictionary)
    }
    
    /// Encode an optional dictionary to a container
    ///
    /// - Parameters:
    ///   - dictionary: Any dictionary type where the Key is DictionaryKeyCodable and Value is Any where can cast to Encodable
    ///   - container: The container to encode to
    ///   - key: The key in the container to encode the dictionary to
    @discardableResult
    mutating func encodeAnyDictionaryIfPresent<D>(_ dictionary: D?) throws -> Bool where D: SDictionary, D.Key: DictionaryKeyCodable, D.Value == Any {
        guard let d = dictionary else { return false }
        try self.encodeAnyDictionary(d)
        return true
    }
    
    
}

public extension UnkeyedEncodingContainer {
    /// Encodes an array of Any to an UnkeyedEncodingContainer if possible
    ///
    /// Note: All objects within the array must implement the Encodable protocol
    ///
    /// - Parameters:
    ///   - array: The array of objects to encode
    /// - Throws: EncodingError.invalidValue if the object can not encoded
    internal mutating func _encodeAnyArray<S>(_ array: S) throws where S: Sequence, S.Element == Any {
        for (i, v) in array.enumerated() {
            if let dV = v as? Dictionary<String, Any> {
                try self.encodeAnyDictionary(dV)
            } else if let dV = v as? Dictionary<Bool, Any> {
                try self.encodeAnyDictionary(dV)
            } else if let dV = v as? Dictionary<Int, Any> {
                try self.encodeAnyDictionary(dV)
            } else if let dV = v as? SCDictionary<String, Any> {
                try self.encodeAnyDictionary(dV)
            } else if let dV = v as? SCDictionary<Bool, Any> {
                try self.encodeAnyDictionary(dV)
            } else if let dV = v as? SCDictionary<Int, Any> {
                try self.encodeAnyDictionary(dV)
            } else if let dV = v as? SCArrayOrderedDictionary<String, Any> {
                try self.encodeAnyDictionary(dV)
            } else if let dV = v as? SCArrayOrderedDictionary<Bool, Any> {
                try self.encodeAnyDictionary(dV)
            } else if let dV = v as? SCArrayOrderedDictionary<Int, Any> {
                try self.encodeAnyDictionary(dV)
            } else if let aV = v as? Array<Any> {
                try self._encodeAnyArray(aV)
            } else if let aV = v as? SCArray<Any> {
                try self._encodeAnyArray(aV)
            } else if let nV = v as? Nillable, nV.isNil {
                try self.encodeNil()
            } else if let eV = v as? Encodable {
                try eV.encode(to: self.superEncoder())
                //let wrappedEncoder = WrappedSingleValueEncoder(self.superEncoder().singleValueContainer())
                //try eV.encode(to: wrappedEncoder)
                /*let wrappedEncoder = WrappedUnKeyedEncoder(container)
                 try eV.encode(to: wrappedEncoder)*/
            } else {
                let description = "Expected value to conform to Encodable but found \(type(of: v)) instead."
                throw EncodingError.invalidValue(v, EncodingError.Context(codingPath: self.codingPath.appending(index: i), debugDescription: description))
            }
        }
    }
    
    /// Encodes an array of Any to the container
    ///
    /// Note: All objects within the array must implement the Encodable protocol
    ///
    /// - Parameters:
    ///   - array: The array of objects to encode
    /// - Throws: EncodingError.invalidValue if the object can not encoded
    mutating func encodeAnyArray<S>(_ array: S) throws where S: Sequence, S.Element == Any {
        var container = self.nestedUnkeyedContainer()
        try container._encodeAnyArray(array)
    }
    
    /// Encodes an array of Any to the container if possible
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
        try self.encodeAnyArray(a)
        return true
    }
}
