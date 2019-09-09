//
//  WrappedSingleValueDecoder.swift
//  AdvancedCodableHelpers
//
//  Created by Tyler Anger on 2018-11-06.
//

import Foundation

/// A decoder that wraps a single value decoding container.
///
/// Unsupported functions: container, unkeyedContainer
public class WrappedSingleValueDecoder: Decoder {
    
    public var userInfo: [CodingUserInfoKey : Any] = [:]
    internal var container: SingleValueDecodingContainer
    //public var codingPath: [CodingKey] { return self.container.codingPath }
    public let codingPath: [CodingKey]
    public init(_ container: SingleValueDecodingContainer) {
        self.container = container
        self.codingPath = container.codingPath
    }
    
    public func container<Key>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> where Key : CodingKey {
        //return try self.container.nestedContainer(keyedBy: type)
        fatalError("Unsupported method")
    }
    
    public func unkeyedContainer() throws -> UnkeyedDecodingContainer {
        //return try self.container.nestedUnkeyedContainer()
        fatalError("Unsupported method")
    }
    
    public func singleValueContainer() throws -> SingleValueDecodingContainer {
        return container
    }
}
