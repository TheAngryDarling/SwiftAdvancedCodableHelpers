//
//  FilteredKeyedEncodingContainer.swift
//  AdvancedCodableHelpers
//
//  Created by Tyler Anger on 2018-11-06.
//

import Foundation

/// Filtered keyed encoding container.
///
/// Allows coder to fileter out specific keyed objecs when encoding
public class FilteredKeyedEncodingContainer<K>: FilteredEncodingContainer, KeyedEncodingContainerProtocol where K: CodingKey {
    
    public typealias Key = K
    private var container: KeyedEncodingContainer<Key>
    
    
    public init(_ container: KeyedEncodingContainer<Key>, rootContainer: FilteredEncodingContainer? = nil, filter: @escaping FilterEncoding) {
        self.container = container
        super.init(codingPath: container.codingPath, rootContainer: rootContainer, filter: filter)
    }
    
    /// Helpful method of creating a KeyedEncodingContainer out of the current container
    ///
    /// - Returns: Returns a KeyedEncodingContainer wrapped around this instance
    public func toKeyedContainer() -> KeyedEncodingContainer<Key> {
        return KeyedEncodingContainer<Key>(self)
    }
    
    public func encodeNil(forKey key: K) throws {
        if try self.canEncode(method: #function, childKey: key, value: nil) {
            try container.encodeNil(forKey: key)
        }
    }
    
    public func encode(_ value: Bool, forKey key: K) throws {
        if try self.canEncode(method: #function, childKey: key, value: value) {
            try container.encode(value, forKey: key)
        }
    }
    
    public func encode(_ value: String, forKey key: K) throws {
        if try self.canEncode(method: #function, childKey: key, value: value) {
            try container.encode(value, forKey: key)
        }
    }
    
    public func encode(_ value: Double, forKey key: K) throws {
        if try self.canEncode(method: #function, childKey: key, value: value) {
            try container.encode(value, forKey: key)
        }
    }
    
    public func encode(_ value: Float, forKey key: K) throws {
        if try self.canEncode(method: #function, childKey: key, value: value) {
            try container.encode(value, forKey: key)
        }
    }
    
    public func encode(_ value: Int, forKey key: K) throws {
        if try self.canEncode(method: #function, childKey: key, value: value) {
            try container.encode(value, forKey: key)
        }
    }
    
    public func encode(_ value: Int8, forKey key: K) throws {
        if try self.canEncode(method: #function, childKey: key, value: value) {
            try container.encode(value, forKey: key)
        }
    }
    
    public func encode(_ value: Int16, forKey key: K) throws {
        if try self.canEncode(method: #function, childKey: key, value: value) {
            try container.encode(value, forKey: key)
        }
    }
    
    public func encode(_ value: Int32, forKey key: K) throws {
        if try self.canEncode(method: #function, childKey: key, value: value) {
            try container.encode(value, forKey: key)
        }
    }
    
    public func encode(_ value: Int64, forKey key: K) throws {
        if try self.canEncode(method: #function, childKey: key, value: value) {
            try container.encode(value, forKey: key)
        }
    }
    
    public func encode(_ value: UInt, forKey key: K) throws {
        if try self.canEncode(method: #function, childKey: key, value: value) {
            try container.encode(value, forKey: key)
        }
    }
    
    public func encode(_ value: UInt8, forKey key: K) throws {
        if try self.canEncode(method: #function, childKey: key, value: value) {
            try container.encode(value, forKey: key)
        }
    }
    
    public func encode(_ value: UInt16, forKey key: K) throws {
        if try self.canEncode(method: #function, childKey: key, value: value) {
            try container.encode(value, forKey: key)
        }
    }
    
    public func encode(_ value: UInt32, forKey key: K) throws {
        if try self.canEncode(method: #function, childKey: key, value: value) {
            try container.encode(value, forKey: key)
        }
    }
    
    public func encode(_ value: UInt64, forKey key: K) throws {
        if try self.canEncode(method: #function, childKey: key, value: value) {
            try container.encode(value, forKey: key)
        }
    }
    
    public func encode<T>(_ value: T, forKey key: K) throws where T : Encodable {
        if try self.canEncode(method: #function, childKey: key, value: value) {
            try container.encode(value, forKey: key)
        }
    }
    
    public func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type, forKey key: K) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey {
        let n = self.container.nestedContainer(keyedBy: keyType, forKey: key)
        let rtn = FilteredKeyedEncodingContainer<NestedKey>(n, rootContainer: self.rootContainer ?? self, filter: self.filterEncoding)
        return KeyedEncodingContainer<NestedKey>(rtn)
        
    }
    
    public func nestedUnkeyedContainer(forKey key: K) -> UnkeyedEncodingContainer {
        let n = self.container.nestedUnkeyedContainer(forKey: key)
        let rtn = FilteredUnkeyedEncodingContainer(n, rootContainer: self.rootContainer ?? self, filter: self.filterEncoding)
        return rtn.codableObject()
    }
    
    public func superEncoder() -> Encoder {
        return self.container.superEncoder()
    }
    
    public func superEncoder(forKey key: K) -> Encoder {
        return self.container.superEncoder(forKey: key)
    }
    
}
