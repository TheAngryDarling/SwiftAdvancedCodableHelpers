//
//  WrappedUnkeyedSingleValueDecoder.swift
//  AdvancedCodableHelpers
//
//  Created by Tyler Anger on 2019-08-05.
//

import Foundation
/// A decoder that wraps an unkeyed decoding container for a single value in the array
public class WrappedUnkeyedSingleValueDecoder: Decoder, SingleValueDecodingContainer {
    
    public var userInfo: [CodingUserInfoKey : Any] = [:]
    internal var container: UnkeyedDecodingContainer
    //public var codingPath: [CodingKey] { return self.container.codingPath }
    public let codingPath: [CodingKey]
    public init(_ container: UnkeyedDecodingContainer) {
        self.container = container
        self.codingPath = container.codingPath.appending(index: container.currentIndex)
    }
    
    public func container<Key>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> where Key : CodingKey {
        return try self.container.nestedContainer(keyedBy: type)
    }
    
    public func unkeyedContainer() throws -> UnkeyedDecodingContainer {
        return try self.container.nestedUnkeyedContainer()
    }
    
    public func singleValueContainer() throws -> SingleValueDecodingContainer {
        return self
    }
    
    public func decodeNil() -> Bool {
        return try! self.container.decodeNil()
    }
    
    public func decode(_ type: Bool.Type) throws -> Bool {
        return try self.container.decode(type)
    }
    
    public func decode(_ type: String.Type) throws -> String {
        return try self.container.decode(type)
    }
    
    public func decode(_ type: Double.Type) throws -> Double {
        return try self.container.decode(type)
    }
    
    public func decode(_ type: Float.Type) throws -> Float {
        return try self.container.decode(type)
    }
    
    public func decode(_ type: Int.Type) throws -> Int {
        return try self.container.decode(type)
    }
    
    public func decode(_ type: Int8.Type) throws -> Int8 {
        return try self.container.decode(type)
    }
    
    public func decode(_ type: Int16.Type) throws -> Int16 {
        return try self.container.decode(type)
    }
    
    public func decode(_ type: Int32.Type) throws -> Int32 {
        return try self.container.decode(type)
    }
    
    public func decode(_ type: Int64.Type) throws -> Int64 {
        return try self.container.decode(type)
    }
    
    public func decode(_ type: UInt.Type) throws -> UInt {
        return try self.container.decode(type)
    }
    
    public func decode(_ type: UInt8.Type) throws -> UInt8 {
        return try self.container.decode(type)
    }
    
    public func decode(_ type: UInt16.Type) throws -> UInt16 {
        return try self.container.decode(type)
    }
    
    public func decode(_ type: UInt32.Type) throws -> UInt32 {
        return try self.container.decode(type)
    }
    
    public func decode(_ type: UInt64.Type) throws -> UInt64 {
        return try self.container.decode(type)
    }
    
    public func decode<T>(_ type: T.Type) throws -> T where T : Decodable {
        return try self.container.decode(type)
    }
}
