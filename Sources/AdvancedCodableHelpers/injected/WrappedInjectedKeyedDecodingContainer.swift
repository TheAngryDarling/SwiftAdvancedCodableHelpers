//
//  InjectedKeyedDecodingContainer.swift
//  AdvancedCodableHelpers
//
//  Created by Tyler Anger on 2018-11-06.
//

import Foundation
import Nillable

/// A wrapped Keyed Decoding Container that allows you to inject or replace key/value pair within the decoding process
public class WrappedInjectedKeyedDecodingContainer<Key>: WrappedKeyedDecodingContainer<Key> where Key: CodingKey {
    
    /*private struct HashedKey: Hashable {
        
        let key: Key
        #if !swift(>=4.2)
        public var hashValue: Int { return key.stringValue.hashValue }
        #endif
        public init(_ key: Key) { self.key = key }
        public init(_ key: String) {
            self.init(Key(stringValue: key)!)
        }
        
        #if swift(>=4.2)
        public func hash(into hasher: inout Hasher) {
            hasher.combine(self.key.stringValue)
        }
        #endif
        
        static func == (lhs: WrappedInjectedKeyedDecodingContainer<K>.HashedKey, rhs: WrappedInjectedKeyedDecodingContainer<K>.HashedKey) -> Bool {
            return lhs.key.stringValue == rhs.key.stringValue
        }
    }*/
    
    //private var injections: [HashedKey: Any] = [:]
    private var injections: [(key: Key, value: Any)] = []
    //private var injectionKeys: [Key] = []
    //private var injectionValues: [Any] = []
    
    //private var container: KeyedDecodingContainer<Key>
    
    //public var codingPath: [CodingKey] { return self.container.codingPath }
    //public var codingPath: [CodingKey]
    public override var allKeys: [Key] {
        var rtn: [Key] = super.allKeys
        for i in self.injections {
            if !rtn.contains(where: { $0.stringValue ==  i.key.stringValue &&  $0.intValue ==  i.key.intValue }) {
                rtn.append(i.key)
            }
        }
        return rtn
    }
    
    public init<Container>(_ container: Container,
                           customCodingPath: [CodingKey]? = nil,
                           injections: [(key: Key, value: Any)]) where Key == Container.Key, Container : KeyedDecodingContainerProtocol {
        self.injections = injections
        super.init(container, customCodingPath: customCodingPath)
    }
    
    public convenience init<Container>(_ container: Container,
                                       customCodingPath: [CodingKey]? = nil,
                                       injections: [String: Any]) where Key == Container.Key, Container : KeyedDecodingContainerProtocol {
        var injs: [(key: Key, value: Any)] = []
        for (k,v) in injections {
            if let key = Key(stringValue: k) {
                injs.append((key: key, value: v))
            }
        }
        self.init(container, customCodingPath: customCodingPath, injections: injs)
    }
    
    public convenience init<Container>(_ container: Container,
                                       customCodingPath: [CodingKey]? = nil,
                                       injection: (key: String, value: Any)) where Key == Container.Key, Container : KeyedDecodingContainerProtocol {
        self.init(container, customCodingPath: customCodingPath, injections: [injection.key: injection.value])
    }
    
    private func injectionValue(forKey key: Key) -> Any? {
        for i in self.injections {
            if i.key.stringValue == key.stringValue && i.key.intValue == key.intValue {
                return i.value
            }
        }
        return nil
    }
    
    private func containsInjectionKey(_ key: Key) -> Bool {
        for i in self.injections {
            if i.key.stringValue == key.stringValue && i.key.intValue == key.intValue {
                return true
            }
        }
        return false
    }
    
    public override func contains(_ key: Key) -> Bool {
        //return self.injections.keys.contains(HashedKey(key)) || self.container.contains(key)
        return self.containsInjectionKey(key) || super.contains(key)
    }
    
    public override func decodeNil(forKey key: Key) throws -> Bool {
        guard let aV = self.injectionValue(forKey: key), let v = aV as? Nillable else { return try super.decodeNil(forKey: key) }
        return v.isNil
    }
    
    public override func decode(_ type: Bool.Type, forKey key: Key) throws -> Bool {
        guard let aV = self.injectionValue(forKey: key), let v = aV as? Bool else { return try super.decode(type, forKey: key) }
        return v
    }
    
    public override func decode(_ type: String.Type, forKey key: Key) throws -> String {
        guard let aV = self.injectionValue(forKey: key), let v = aV as? String else { return try super.decode(type, forKey: key) }
        return v
    }
    
    public override func decode(_ type: Double.Type, forKey key: Key) throws -> Double {
        guard let aV = self.injectionValue(forKey: key), let v = aV as? Double else { return try super.decode(type, forKey: key) }
        return v
    }
    
    public override func decode(_ type: Float.Type, forKey key: Key) throws -> Float {
        guard let aV = self.injectionValue(forKey: key), let v = aV as? Float else { return try super.decode(type, forKey: key) }
        return v
    }
    
    public override func decode(_ type: Int.Type, forKey key: Key) throws -> Int {
        guard let aV = self.injectionValue(forKey: key), let v = aV as? Int else { return try super.decode(type, forKey: key) }
        return v
    }
    
    public override func decode(_ type: Int8.Type, forKey key: Key) throws -> Int8 {
        guard let aV = self.injectionValue(forKey: key), let v = aV as? Int8 else { return try super.decode(type, forKey: key) }
        return v
    }
    
    public override func decode(_ type: Int16.Type, forKey key: Key) throws -> Int16 {
        guard let aV = self.injectionValue(forKey: key), let v = aV as? Int16 else { return try super.decode(type, forKey: key) }
        return v
    }
    
    public override func decode(_ type: Int32.Type, forKey key: Key) throws -> Int32 {
        guard let aV = self.injectionValue(forKey: key), let v = aV as? Int32 else { return try super.decode(type, forKey: key) }
        return v
    }
    
    public override func decode(_ type: Int64.Type, forKey key: Key) throws -> Int64 {
        guard let aV = self.injectionValue(forKey: key), let v = aV as? Int64 else { return try super.decode(type, forKey: key) }
        return v
    }
    
    public override func decode(_ type: UInt.Type, forKey key: Key) throws -> UInt {
        guard let aV = self.injectionValue(forKey: key), let v = aV as? UInt else { return try super.decode(type, forKey: key) }
        return v
    }
    
    public override func decode(_ type: UInt8.Type, forKey key: Key) throws -> UInt8 {
        guard let aV = self.injectionValue(forKey: key), let v = aV as? UInt8 else { return try super.decode(type, forKey: key) }
        return v
    }
    
    public override func decode(_ type: UInt16.Type, forKey key: Key) throws -> UInt16 {
        guard let aV = self.injectionValue(forKey: key), let v = aV as? UInt16 else { return try super.decode(type, forKey: key) }
        return v
    }
    
    public override func decode(_ type: UInt32.Type, forKey key: Key) throws -> UInt32 {
        guard let aV = self.injectionValue(forKey: key), let v = aV as? UInt32 else { return try super.decode(type, forKey: key) }
        return v
    }
    
    public override func decode(_ type: UInt64.Type, forKey key: Key) throws -> UInt64 {
        guard let aV = self.injectionValue(forKey: key), let v = aV as? UInt64 else { return try super.decode(type, forKey: key) }
        return v
    }
    
    public override func decode<T>(_ type: T.Type, forKey key: Key) throws -> T where T : Decodable {
        guard let aV = self.injectionValue(forKey: key) else {
            //print("\(self.codingPath.appending(key).stringPath)")
            return try super.decode(type, forKey: key)
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
    
    public override func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type,
                                                    forKey key: Key) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey {
        guard let aV = self.injectionValue(forKey: key) else { return try super.nestedContainer(keyedBy: type, forKey: key) }
        if let d = aV as? [String: Any] {
            let injector = InjectedKeyedDecodingContainer<CodableKey>(self.codingPath.appending(key), injections: d)
            let bridge = BridgedKeyedDecodingContainer<CodableKey, NestedKey>(injector)
            return KeyedDecodingContainer<NestedKey>(bridge)
        } else {
            throw DecodingError._typeMismatch(at: self.codingPath.appending(key), expectation: type, reality: aV)
        }
    }
    
    public override func nestedUnkeyedContainer(forKey key: Key) throws -> UnkeyedDecodingContainer {
        guard let aV = self.injectionValue(forKey: key) else { return try super.nestedUnkeyedContainer(forKey: key) }
        var newPath: [CodingKey] = []
        newPath.append(contentsOf: self.codingPath)
        newPath.append(key)
        return InjectedUnkeyedDecodingContainer(newPath, object: aV)
    }
    
    public override func superDecoder() throws -> Decoder {
        return try super.superDecoder()
    }
    
    public override func superDecoder(forKey key: Key) throws -> Decoder {
        return try super.superDecoder(forKey: key)
    }
    
    
}
