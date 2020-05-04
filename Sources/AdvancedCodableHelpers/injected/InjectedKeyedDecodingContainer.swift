//
//  InjectedKeyedDecodingContainer.swift
//  AdvancedCodableHelpers
//
//  Created by Tyler Anger on 2018-11-06.
//

import Foundation

/// A keyed decoding container that allows the coder to inject extra keyed values into the decoding process
///
/// Unsupported functions: superDecoder(), superDecoder(forKey:)
public class InjectedKeyedDecodingContainer<K>: KeyedDecodingContainerProtocol where K: CodingKey {
    public typealias Key = K
    
    /*private struct HashedKey: Hashable {
        
        let key: Key
        
        #if !swift(>=4.1)
        public var hashValue: Int { return key.stringValue.hashValue }
        #endif
        
        public init(_ key: Key) { self.key = key }
        public init(_ key: String) {
            self.init(Key(stringValue: key)!)
        }
        
        #if swift(>=4.1)
        public func hash(into hasher: inout Hasher) {
            hasher.combine(self.key.stringValue)
        }
        #endif
        
        static func == (lhs: InjectedKeyedDecodingContainer<K>.HashedKey, rhs: InjectedKeyedDecodingContainer<K>.HashedKey) -> Bool {
            return lhs.key.stringValue == rhs.key.stringValue
        }
    }*/
    
    private var injections: [String: Any] = [:]
    public let codingPath: [CodingKey]
    public var allKeys: [K] {
        var rtn: [K] = []
        for k in self.injections.keys {
            // Must try and add injected keys if they do not exist alread
            if let kv = K(stringValue: k) {
                if !rtn.contains(where: { $0.stringValue ==  k }) {
                    rtn.append(kv)
                }
            }
        }
        return rtn
    }
    
    public init(_ codingPath: [CodingKey], injections: [String: Any]) {
        self.codingPath = codingPath
        self.injections = injections
    }
    
    public convenience init(_ codingPath: [CodingKey], injection: (key: String, value: Any)) {
        self.init(codingPath, injections: [injection.key: injection.value])
    }
    
    public func toKeyedContainer() -> KeyedDecodingContainer<Key> {
        return KeyedDecodingContainer<Key>(self)
    }
    
    
    
    public func contains(_ key: K) -> Bool {
        return self.injections.keys.contains(key.stringValue)
    }
    
    public func decodeNil(forKey key: K) throws -> Bool {
        return !self.injections.keys.contains(key.stringValue)
        //return try self.container.decodeNil(forKey: key)
    }
    
    public func decode(_ type: Bool.Type, forKey key: K) throws -> Bool {
        guard let aV = self.injections[key.stringValue], let v = aV as? Bool else {
            throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath:  self.codingPath.appending(key), debugDescription: "Key Not Found"))
        }
        return v
    }
    
    public func decode(_ type: String.Type, forKey key: K) throws -> String {
        guard let aV = self.injections[key.stringValue], let v = aV as? String else {
            throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath:  self.codingPath.appending(key), debugDescription: "Key Not Found"))
        }
        return v
    }
    
    public func decode(_ type: Double.Type, forKey key: K) throws -> Double {
        guard let aV = self.injections[key.stringValue], let v = aV as? Double else {
            throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath:  self.codingPath.appending(key), debugDescription: "Key Not Found"))
        }
        return v
    }
    
    public func decode(_ type: Float.Type, forKey key: K) throws -> Float {
        guard let aV = self.injections[key.stringValue], let v = aV as? Float else {
            throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath:  self.codingPath.appending(key), debugDescription: "Key Not Found"))
        }
        return v
    }
    
    public func decode(_ type: Int.Type, forKey key: K) throws -> Int {
        guard let aV = self.injections[key.stringValue], let v = aV as? Int else {
            throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath:  self.codingPath.appending(key), debugDescription: "Key Not Found"))
        }
        return v
    }
    
    public func decode(_ type: Int8.Type, forKey key: K) throws -> Int8 {
        guard let aV = self.injections[key.stringValue], let v = aV as? Int8 else {
            throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath:  self.codingPath.appending(key), debugDescription: "Key Not Found"))
        }
        return v
    }
    
    public func decode(_ type: Int16.Type, forKey key: K) throws -> Int16 {
        guard let aV = self.injections[key.stringValue], let v = aV as? Int16 else {
            throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath:  self.codingPath.appending(key), debugDescription: "Key Not Found"))
        }
        return v
    }
    
    public func decode(_ type: Int32.Type, forKey key: K) throws -> Int32 {
        guard let aV = self.injections[key.stringValue], let v = aV as? Int32 else {
            throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath:  self.codingPath.appending(key), debugDescription: "Key Not Found"))
        }
        return v
    }
    
    public func decode(_ type: Int64.Type, forKey key: K) throws -> Int64 {
        guard let aV = self.injections[key.stringValue], let v = aV as? Int64 else {
            throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath:  self.codingPath.appending(key), debugDescription: "Key Not Found"))
        }
        return v
    }
    
    public func decode(_ type: UInt.Type, forKey key: K) throws -> UInt {
        guard let aV = self.injections[key.stringValue], let v = aV as? UInt else {
            throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath:  self.codingPath.appending(key), debugDescription: "Key Not Found"))
        }
        return v
    }
    
    public func decode(_ type: UInt8.Type, forKey key: K) throws -> UInt8 {
        guard let aV = self.injections[key.stringValue], let v = aV as? UInt8 else {
            throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath:  self.codingPath.appending(key), debugDescription: "Key Not Found"))
        }
        return v
    }
    
    public func decode(_ type: UInt16.Type, forKey key: K) throws -> UInt16 {
        guard let aV = self.injections[key.stringValue], let v = aV as? UInt16 else {
            throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath:  self.codingPath.appending(key), debugDescription: "Key Not Found"))
        }
        return v
    }
    
    public func decode(_ type: UInt32.Type, forKey key: K) throws -> UInt32 {
        guard let aV = self.injections[key.stringValue], let v = aV as? UInt32 else {
            throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath:  self.codingPath.appending(key), debugDescription: "Key Not Found"))
        }
        return v
    }
    
    public func decode(_ type: UInt64.Type, forKey key: K) throws -> UInt64 {
        guard let aV = self.injections[key.stringValue], let v = aV as? UInt64 else {
            throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath:  self.codingPath.appending(key), debugDescription: "Key Not Found"))
        }
        return v
    }
    
    public func decode<T>(_ type: T.Type, forKey key: K) throws -> T where T : Decodable {
        guard let aV = self.injections[key.stringValue] else {
            throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath:  self.codingPath.appending(key), debugDescription: "Key Not Found"))
        }
        if let v = aV as? T { return v }
        else if let d = aV as? [String: Any] {
            let injector = InjectedKeyedDecodingContainer<CodableKey>(self.codingPath.appending(key), injections: d)
            let decoder = WrappedKeyedDecoder<CodableKey>(injector)
            return try T(from: decoder)
        } else if let a = aV as? [Any] {
            let injector = InjectedUnkeyedDecodingContainer(self.codingPath.appending(key), objects: a)
            let decoder = WrappedUnkeyedDecoder(injector)
            return try T(from: decoder)
        } else {
            let injector = InjectedSingleValueDecodingContainer(self.codingPath.appending(key), object: aV)
            let decoder = WrappedSingleValueDecoder(injector)
            return try T(from: decoder)
            
            //throw DecodingError._typeMismatch(at: self.codingPath.appending(key), expectation: type, reality: aV)
        }
    }
    
    public func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type, forKey key: K) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey {
        let aV = self.injections[key.stringValue] ?? Dictionary<String, Any>()
        if let d = aV as? [String: Any] {
            let injector = InjectedKeyedDecodingContainer<CodableKey>(self.codingPath.appending(key), injections: d)
            let bridge = BridgedKeyedDecodingContainer<CodableKey, NestedKey>(injector)
            return KeyedDecodingContainer<NestedKey>(bridge)
        } else {
            throw DecodingError._typeMismatch(at: self.codingPath.appending(key), expectation: type, reality: aV)
        }
    }
    
    public func nestedUnkeyedContainer(forKey key: K) throws -> UnkeyedDecodingContainer {
        guard let aV = self.injections[key.stringValue] else {
            throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath:  self.codingPath.appending(key), debugDescription: "Key Not Found"))
        }
        return InjectedUnkeyedDecodingContainer(self.codingPath.appending(key), object: aV)
    }
    
    private func _superDecoder(forKey key: CodingKey) throws -> Decoder {
        fatalError("Unsupported Method")
    }
    
    public func superDecoder() throws -> Decoder {
        return try _superDecoder(forKey: CodableKey.super)
    }
    
    public func superDecoder(forKey key: K) throws -> Decoder {
        return try _superDecoder(forKey: key)
    }
    
    
}

