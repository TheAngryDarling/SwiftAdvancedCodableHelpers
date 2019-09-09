//
//  WrappedPreKeyedSingleValueDecodingContainer.swift
//  AdvancedCodableHelpers
//
//  Created by Tyler Anger on 2019-08-05.
//

import Foundation

/// A SingleValueDecodingContainer wrapper for a KeyedDecodingContainer with a specific key
public class WrappedPreKeyedSingleValueDecodingContainer<K>: SingleValueDecodingContainer where K: CodingKey {
    
    internal var container: KeyedDecodingContainer<K>
    private let preKey: K
    
    public let codingPath: [CodingKey]
    
    /// Create new instance of WrappedPreKeyedSingleValueDecodingContainer
    ///
    /// - Parameters:
    ///   - container: The KeyedDecodingContainer to work on
    ///   - preKey: The key within the container to work with
    public init(_ container: KeyedDecodingContainer<K>, preKey: K) {
        self.container = container
        self.preKey = preKey
        self.codingPath = container.codingPath.appending(preKey)
    }
    
    /// Create new instance of WrappedPreKeyedSingleValueDecodingContainer
    ///
    /// - Parameters:
    ///   - container: The KeyedDecodingContainer to work on
    ///   - preKey: The key within the container to work with
    public init<Container>(_ container: Container, preKey: K) where K == Container.Key, Container : KeyedDecodingContainerProtocol {
        self.container = KeyedDecodingContainer<K>(container)
        self.preKey = preKey
        self.codingPath = container.codingPath.appending(preKey)
    }
    
    public func decodeNil() -> Bool {
        return (try? self.container.decodeNil(forKey: self.preKey)) ?? false
    }
    
    public func decode(_ type: Bool.Type) throws -> Bool {
        return try self.container.decode(type, forKey: self.preKey)
    }
    
    public func decode(_ type: String.Type) throws -> String {
        return try self.container.decode(type, forKey: self.preKey)
    }
    
    public func decode(_ type: Double.Type) throws -> Double {
        return try self.container.decode(type, forKey: self.preKey)
    }
    
    public func decode(_ type: Float.Type) throws -> Float {
        return try self.container.decode(type, forKey: self.preKey)
    }
    
    public func decode(_ type: Int.Type) throws -> Int {
        return try self.container.decode(type, forKey: self.preKey)
    }
    
    public func decode(_ type: Int8.Type) throws -> Int8 {
        return try self.container.decode(type, forKey: self.preKey)
    }
    
    public func decode(_ type: Int16.Type) throws -> Int16 {
        return try self.container.decode(type, forKey: self.preKey)
    }
    
    public func decode(_ type: Int32.Type) throws -> Int32 {
        return try self.container.decode(type, forKey: self.preKey)
    }
    
    public func decode(_ type: Int64.Type) throws -> Int64 {
        return try self.container.decode(type, forKey: self.preKey)
    }
    
    public func decode(_ type: UInt.Type) throws -> UInt {
        return try self.container.decode(type, forKey: self.preKey)
    }
    
    public func decode(_ type: UInt8.Type) throws -> UInt8 {
        return try self.container.decode(type, forKey: self.preKey)
    }
    
    public func decode(_ type: UInt16.Type) throws -> UInt16 {
        return try self.container.decode(type, forKey: self.preKey)
    }
    
    public func decode(_ type: UInt32.Type) throws -> UInt32 {
        return try self.container.decode(type, forKey: self.preKey)
    }
    
    public func decode(_ type: UInt64.Type) throws -> UInt64 {
        return try self.container.decode(type, forKey: self.preKey)
    }
    
    public func decode<T>(_ type: T.Type) throws -> T where T : Decodable {
        return try self.container.decode(type, forKey: self.preKey)
    }
}
