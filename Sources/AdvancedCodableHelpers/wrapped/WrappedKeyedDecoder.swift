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
    
    public enum ModifyCodingPath {
        case none
        case override([CodingKey])
        case append([CodingKey])
        
        public static func appending(_ codingKeys: CodingKey...) -> ModifyCodingPath {
            return .append(codingKeys)
        }
        
        public static func overriding(_ codingKeys: CodingKey...) -> ModifyCodingPath {
            return .override(codingKeys)
        }
        
        public func update(_ container: KeyedDecodingContainer<K>) -> [CodingKey] {
            switch self {
                case .none: return container.codingPath
                case .override(let rtn): return rtn
                case .append(let paths):
                    var rtn = container.codingPath
                    rtn.append(contentsOf: paths)
                    return rtn
            }
        }
    }
    
    public var userInfo: [CodingUserInfoKey : Any] = [:]
    internal var container: KeyedDecodingContainer<K>
   
    public let codingPath: [CodingKey]
    public init(_ container: KeyedDecodingContainer<K>,
                codingPathModifier: ModifyCodingPath = .none) {
        self.container = container
        self.codingPath = codingPathModifier.update(container)
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


