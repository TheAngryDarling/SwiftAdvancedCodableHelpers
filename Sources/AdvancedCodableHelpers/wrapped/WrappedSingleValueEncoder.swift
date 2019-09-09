//
//  WrappedSingleValueEncoder.swift
//  AdvancedCodableHelpers
//
//  Created by Tyler Anger on 2018-11-06.
//

import Foundation

/// An encoder that wraps a single value encoding container.
///
/// Unsupported functions: container, unkeyedContainer
public class WrappedSingleValueEncoder: Encoder {
    
    public var userInfo: [CodingUserInfoKey : Any] = [:]
    internal var container: SingleValueEncodingContainer
    //public var codingPath: [CodingKey] { return self.container.codingPath }
    public let codingPath: [CodingKey]
    public init(_ container: SingleValueEncodingContainer) {
        self.container = container
        self.codingPath = container.codingPath
    }
    
    public func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key : CodingKey {
        //return try self.container.nestedContainer(keyedBy: type)
        fatalError("Unsupported method")
    }
    
    public func unkeyedContainer() -> UnkeyedEncodingContainer {
        //return try self.container.nestedUnkeyedContainer()
        fatalError("Unsupported method")
    }
    
    public func singleValueContainer() -> SingleValueEncodingContainer {
        return container
    }
}
