//
//  WrappedUnKeyedDecoder.swift
//  AdvancedCodableHelpers
//
//  Created by Tyler Anger on 2018-11-03.
//

import Foundation

/// A decoder that wraps an unkeyed decoding container.
///
/// Unsupported functions: container
public class WrappedUnkeyedDecoder: Decoder, SingleValueDecodingContainer {
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
        
        public func update(_ container: UnkeyedDecodingContainer) -> [CodingKey] {
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
    internal var container: UnkeyedDecodingContainer
    //public var codingPath: [CodingKey] { return self.container.codingPath }
    public let codingPath: [CodingKey]
    public init(_ container: UnkeyedDecodingContainer, codingPathModifier: ModifyCodingPath = .none) {
        self.container = container
        self.codingPath = codingPathModifier.update(container)
    }
    
    public func container<Key>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> where Key : CodingKey {
        return try self.container.nestedContainer(keyedBy: type)
        // fatalError("Unsupported method")
    }
    
    public func unkeyedContainer() throws -> UnkeyedDecodingContainer {
        //return try self.container.nestedUnkeyedContainer()
        return self.container
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




