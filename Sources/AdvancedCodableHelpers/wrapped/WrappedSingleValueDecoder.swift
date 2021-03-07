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
        
        public func update(_ container: SingleValueDecodingContainer) -> [CodingKey] {
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
    internal var container: SingleValueDecodingContainer
    //public var codingPath: [CodingKey] { return self.container.codingPath }
    public let codingPath: [CodingKey]
    public init(_ container: SingleValueDecodingContainer,
                codingPathModifier: ModifyCodingPath = .none) {
        self.container = container
        self.codingPath = codingPathModifier.update(container)
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
