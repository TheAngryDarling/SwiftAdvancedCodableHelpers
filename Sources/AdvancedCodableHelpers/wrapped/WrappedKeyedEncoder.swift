//
//  WrappedKeyedEncoder.swift
//  AdvancedCodableHelpers
//
//  Created by Tyler Anger on 2018-11-05.
//

import Foundation

/// An encoder that wrapps a keyed encoding container.
///
/// Unsupported functions: unkeyedContainer, singleValueContainer
public class WrappedKeyedEncoder<K>: Encoder where K: CodingKey {
    
    public var userInfo: [CodingUserInfoKey : Any] = [:]
    
    fileprivate var container: KeyedEncodingContainer<K>
    //private var key: Key
    // public var codingPath: [CodingKey] { return self.container.codingPath }
    public let codingPath: [CodingKey]
    
    public init(_ container: KeyedEncodingContainer<K>/*, forKey key: Key*/) {
        self.container = container
        self.codingPath = container.codingPath
    }
    public init<Container>(_ container: Container) where K == Container.Key, Container : KeyedEncodingContainerProtocol {
        self.container = KeyedEncodingContainer<K>(container)
        self.codingPath = container.codingPath
    }
    
    public func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key : CodingKey {
        let rtn = BridgedKeyedEncodingContainer<K, Key>(self.container)
        return KeyedEncodingContainer<Key>(rtn)
    }
    
    public func unkeyedContainer() -> UnkeyedEncodingContainer {
        fatalError("Unsupported method")
    }
    
    public func singleValueContainer() -> SingleValueEncodingContainer {
        fatalError("Unsupported method")
    }
}
