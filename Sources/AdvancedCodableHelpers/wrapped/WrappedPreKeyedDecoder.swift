//
//  WrappedPreKeyedDecoder.swift
//  AdvancedCodableHelpers
//
//  Created by Tyler Anger on 2019-08-05.
//

import Foundation

/// A decoder that wraps a keyed decoding container.
public class WrappedPreKeyedDecoder<K>: Decoder where K: CodingKey {
    
    internal var container: KeyedDecodingContainer<K>
    private let preKey: K
    
    public let codingPath: [CodingKey]
    public var userInfo: [CodingUserInfoKey : Any] = [:]
    
    /// Create new instance of WrappedPreKeyedDecoder
    ///
    /// - Parameters:
    ///   - container: The KeyedDecodingContainer to work on
    ///   - preKey: The key within the container to work with
    public init(_ container: KeyedDecodingContainer<K>, preKey: K) {
        self.container = container
        self.preKey = preKey
        self.codingPath = container.codingPath.appending(preKey)
    }
    
    /// Create new instance of WrappedPreKeyedDecoder
    ///
    /// - Parameters:
    ///   - container: The KeyedDecodingContainer to work on
    ///   - preKey: The key within the container to work with
    public init<Container>(_ container: Container, preKey: K) where K == Container.Key, Container : KeyedDecodingContainerProtocol {
        self.container = KeyedDecodingContainer<K>(container)
        self.preKey = preKey
        self.codingPath = container.codingPath.appending(preKey)
    }
    
    public func container<Key>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> where Key : CodingKey {
        return try self.container.nestedContainer(keyedBy: type, forKey: self.preKey)
    }
    
    public func unkeyedContainer() throws -> UnkeyedDecodingContainer {
        return try self.container.nestedUnkeyedContainer(forKey: self.preKey)
    }
    
    public func singleValueContainer() throws -> SingleValueDecodingContainer {
        return WrappedPreKeyedSingleValueDecodingContainer(self.container, preKey: self.preKey)
    }
}
