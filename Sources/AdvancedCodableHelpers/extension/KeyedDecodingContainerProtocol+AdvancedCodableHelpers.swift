//
//  KeyedDecodingContainerProtocol+AdvancedCodableHelpers.swift
//  AdvancedCodableHelpers
//
//  Created by Tyler Anger on 2019-11-25.
//

import Foundation

public extension KeyedDecodingContainerProtocol {
    /// Dynamically decode a given type.
    /// - Parameters:
    ///   - key: The coding key to decode
    ///   - decodingFunc: The decoding function to call providing the decoder
    ///   - decoder: The decoder used within the custom decoding function
    func decode<T>(forKey key: Self.Key, decodingFunc: (_ decoder: Decoder) throws -> T) throws -> T {
        return try decodingFunc(WrappedPreKeyedDecoder(self, preKey: key))
    }
    /// Dynamically decode a given type if present
    /// - Parameters:
    ///   - key: The coding key to decode
    ///   - decodingFunc: The decoding function to call providing the decoder
    ///   - decoder: The decoder used within the custom decoding function
    func decodeIfPresent<T>(forKey key: Self.Key, decodingFunc: (_ decoder: Decoder) throws -> T) throws -> T? {
        guard self.contains(key) else { return nil }
        return try decode(forKey: key, decodingFunc: decodingFunc)
    }
    
    /// Dynamically decode an array of a given type
    /// - Parameters:
    ///   - key: The coding key to decode
    ///   - decodingFunc: The decoding function to call providing the decoder
    ///   - decoder: The decoder used within the custom decoding function
    func decode<T>(forKey key: Self.Key, decodingFunc: (_ decoder: Decoder) throws -> T) throws -> [T] {
        var container = try self.nestedUnkeyedContainer(forKey: key)
        var rtn: [T] = []
        while !container.isAtEnd {
            
            //let obj = try decodingFunc(WrappedUnkeyedSingleValueDecoder(container))
            let obj = try decodingFunc(try container.superDecoder())
            rtn.append(obj)
        }
        return rtn
        
    }
    /// Dynamically decode an array of a given type if present
    ///
    /// - Parameters:
    ///   - key: The coding key to decode
    ///   - decodingFunc: The decoding function to call providing the decoder
    ///   - decoder: The decoder used within the custom decoding function
    func decodeIfPresent<T>(forKey key: Self.Key, decodingFunc: (_ decoder: Decoder) throws -> T) throws -> [T]? {
        guard self.contains(key) else { return nil }
        return try decode(forKey: key, decodingFunc: decodingFunc)
    }
}
