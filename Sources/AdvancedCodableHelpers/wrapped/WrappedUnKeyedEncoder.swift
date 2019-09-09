//
//  WrappedUnKeyedEncoder.swift
//  AdvancedCodableHelpers
//
//  Created by Tyler Anger on 2018-11-03.
//

import Foundation

/// An encoder that wraps an unkeyed encoding container.
///
/// Unsupported functions: container
public class WrappedUnkeyedEncoder: Encoder, SingleValueEncodingContainer {
    
    public var userInfo: [CodingUserInfoKey : Any] = [:]
    private var container: UnkeyedEncodingContainer
    //public var codingPath: [CodingKey] { return self.container.codingPath }
    public let codingPath: [CodingKey]
    public init(_ container: UnkeyedEncodingContainer) {
        self.container = container
        self.codingPath = container.codingPath
    }
    
    
    
    public func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key : CodingKey {
        //return self.container.nestedContainer(keyedBy: type)
        fatalError("Unsupported method")
    }
    
    public func unkeyedContainer() -> UnkeyedEncodingContainer {
        //return self.container.nestedUnkeyedContainer()
        return self.container
    }
    
    public func singleValueContainer() -> SingleValueEncodingContainer {
        return self
    }
    
    public func encodeNil() throws {
        try self.container.encodeNil()
    }
    
    public func encode(_ value: Bool) throws {
        try self.container.encode(value)
    }
    
    public func encode(_ value: String) throws {
        try self.container.encode(value)
    }
    
    public func encode(_ value: Double) throws {
        try self.container.encode(value)
    }
    
    public func encode(_ value: Float) throws {
        try self.container.encode(value)
    }
    
    public func encode(_ value: Int) throws {
        try self.container.encode(value)
    }
    
    public func encode(_ value: Int8) throws {
        try self.container.encode(value)
    }
    
    public func encode(_ value: Int16) throws {
        try self.container.encode(value)
    }
    
    public func encode(_ value: Int32) throws {
        try self.container.encode(value)
    }
    
    public func encode(_ value: Int64) throws {
        try self.container.encode(value)
    }
    
    public func encode(_ value: UInt) throws {
        try self.container.encode(value)
    }
    
    public func encode(_ value: UInt8) throws {
        try self.container.encode(value)
    }
    
    public func encode(_ value: UInt16) throws {
        try self.container.encode(value)
    }
    
    public func encode(_ value: UInt32) throws {
        try self.container.encode(value)
    }
    
    public func encode(_ value: UInt64) throws {
        try self.container.encode(value)
    }
    
    public func encode<T>(_ value: T) throws where T : Encodable {
        try self.container.encode(value)
    }
}

@available(*, deprecated, renamed: "WrappedUnkeyedEncoder")
public typealias WrappedUnKeyedEncoder=WrappedUnkeyedEncoder
