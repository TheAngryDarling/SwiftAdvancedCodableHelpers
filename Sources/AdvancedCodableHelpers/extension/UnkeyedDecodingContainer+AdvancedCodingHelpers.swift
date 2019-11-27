//
//  UnkeyedDecodingContainer+AdvancedCodingHelpers.swift
//  AdvancedCodableHelpers
//
//  Created by Tyler Anger on 2019-11-25.
//

import Foundation

public extension UnkeyedDecodingContainer {
    /// Dynamically decode a given type.
    /// - Parameters:
    ///   - decodingFunc: The decoding function to call providing the decoder
    ///   - decoder: The decoder used within the custom decoding function
    mutating func decode<T>(decodingFunc: (_ decoder: Decoder) throws -> T) throws -> T {
        
        return try decodingFunc(try self.superDecoder())
    }
    /// Dynamically decode a given type if present.
    /// - Parameters:
    ///   - decodingFunc: The decoding function to call providing the decoder
    ///   - decoder: The decoder used within the custom decoding function
    mutating func decodeIfPresent<T>(decodingFunc: (_ decoder: Decoder) throws -> T) throws -> T? {
        guard !self.isAtEnd else { return nil }
        return try decode(decodingFunc: decodingFunc)
    }
    /// Dynamically decode an array of a given type.
    /// - Parameters:
    ///   - decodingFunc: The decoding function to call providing the decoder
    ///   - decoder: The decoder used within the custom decoding function
    mutating func decode<T>(decodingFunc: (_ decoder: Decoder) throws -> T) throws -> [T] {
        var container = try self.nestedUnkeyedContainer()
        var rtn: [T] = []
        while !container.isAtEnd {
            
            //let obj = try decodingFunc(WrappedUnkeyedSingleValueDecoder(container))
            let obj = try decodingFunc(try container.superDecoder())
            rtn.append(obj)
        }
        return rtn
    }
    /// Dynamically decode an array of a given type if present
    /// - Parameters:
    ///   - decodingFunc: The decoding function to call providing the decoder
    ///   - decoder: The decoder used within the custom decoding function
    mutating func decodeIfPresent<T>(decodingFunc: (_ decoder: Decoder) throws -> T) throws -> [T]? {
        guard !self.isAtEnd else { return nil }
        return try decode(decodingFunc: decodingFunc)
    }
}
