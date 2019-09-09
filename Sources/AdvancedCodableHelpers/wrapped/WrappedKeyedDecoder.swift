//
//  WrappedKeyedDecoder.swift
//  AdvancedCodableHelpers
//
//  Created by Tyler Anger on 2018-11-05.
//

import Foundation

/// A decoder that wraps a keyed decoding container.
///
/// Unsupported functions: unkeyedContainer, singleValueContainer
public class WrappedKeyedDecoder<K>: Decoder where K: CodingKey {
    
    public var userInfo: [CodingUserInfoKey : Any] = [:]
    internal var container: KeyedDecodingContainer<K>
   
    public let codingPath: [CodingKey]
    public init(_ container: KeyedDecodingContainer<K>) {
        self.container = container
        self.codingPath = container.codingPath
    }
    
    public init<Container>(_ container: Container) where K == Container.Key, Container : KeyedDecodingContainerProtocol {
        self.container = KeyedDecodingContainer<K>(container)
        self.codingPath = container.codingPath
    }
    
    public func container<Key>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> where Key : CodingKey {
        let rtn = BridgedKeyedDecodingContainer<K, Key>(self.container)
        return KeyedDecodingContainer<Key>(rtn)
    }
    
    public func unkeyedContainer() throws -> UnkeyedDecodingContainer {
        fatalError("Unsupported method")
    }
    
    public func singleValueContainer() throws -> SingleValueDecodingContainer {
        fatalError("Unsupported method")
    }
}


